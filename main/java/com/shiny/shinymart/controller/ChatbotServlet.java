package com.shiny.shinymart.controller;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

@WebServlet("/chatbot")
public class ChatbotServlet extends HttpServlet {

    private static final String OPENAI_URL =
            "https://api.openai.com/v1/responses";

    private static final String DEFAULT_MODEL =
            "gpt-6-luna";

    private final Gson gson = new Gson();


    @Override
    protected void doGet(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null ||
                session.getAttribute("user") == null) {

            resp.sendRedirect(
                    req.getContextPath() + "/login"
            );
            return;
        }

        req.getRequestDispatcher("/chatbot.jsp")
                .forward(req, resp);
    }


    @Override
    protected void doPost(HttpServletRequest req,
                           HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null ||
                session.getAttribute("user") == null) {

            resp.sendRedirect(
                    req.getContextPath() + "/login"
            );
            return;
        }

        String message = req.getParameter("message");


        // Validate message

        if (message == null ||
                message.trim().isEmpty()) {

            req.setAttribute(
                    "error",
                    "Please enter a question."
            );

            req.getRequestDispatcher("/chatbot.jsp")
                    .forward(req, resp);

            return;
        }


        message = message.trim();


        // Limit message size

        if (message.length() > 500) {

            req.setAttribute(
                    "error",
                    "Please keep your question below 500 characters."
            );

            req.getRequestDispatcher("/chatbot.jsp")
                    .forward(req, resp);

            return;
        }


        // First check FAQ responses

        String faqResponse =
                getFaqResponse(message);


        if (faqResponse != null) {

            req.setAttribute(
                    "chatbotResponse",
                    faqResponse
            );

            req.getRequestDispatcher("/chatbot.jsp")
                    .forward(req, resp);

            return;
        }


        // Try AI response

        try {

            String response =
                    getAIResponse(message);

            req.setAttribute(
                    "chatbotResponse",
                    response
            );

        } catch (Exception e) {

            System.out.println(
                    "Chatbot API error: " + e.getMessage()
            );

            req.setAttribute(
                    "chatbotResponse",
                    getFallbackResponse()
            );
        }


        req.getRequestDispatcher("/chatbot.jsp")
                .forward(req, resp);
    }


    /*
     * FAQ RESPONSES
     */

    private String getFaqResponse(String message) {

        String text =
                message.toLowerCase().trim();


        // 1. Registration

        if (text.contains("register") ||
                text.contains("create account") ||
                text.contains("sign up")) {

            return "To register, open the Register page, "
                    + "enter your name, email, password and role, "
                    + "then submit the form.";
        }


        // 2. Login

        if (text.contains("login") ||
                text.contains("log in") ||
                text.contains("sign in")) {

            return "To login, enter your registered email "
                    + "and password on the Login page.";
        }


        // 3. Add to cart

        if ((text.contains("cart") &&
                text.contains("add")) ||
                text.contains("add product to cart")) {

            return "To add a product to your cart, open the "
                    + "Products page and click 'Add to Cart'.";
        }


        // 4. Checkout

        if (text.contains("checkout") ||
                text.contains("place order") ||
                text.contains("buy product")) {

            return "To checkout, open My Cart, review your "
                    + "items and quantities, then proceed with checkout.";
        }


        // 5. Orders

        if (text.contains("my order") ||
                text.contains("order history") ||
                text.contains("orders")) {

            return "You can view your previous orders from "
                    + "the My Orders page.";
        }


        // 6. Review

        if (text.contains("review") ||
                text.contains("rating") ||
                text.contains("rate product")) {

            return "Open the Products page and click the "
                    + "'Review' link for a product. You can then "
                    + "select a rating and write your comment.";
        }


        // 7. Seller add product

        if ((text.contains("seller") &&
                text.contains("product")) ||
                text.contains("add a product")) {

            return "Sellers can add products from the Products "
                    + "page by entering the product name, description, "
                    + "price, stock quantity and category.";
        }


        // 8. Search

        if (text.contains("search") ||
                text.contains("find product")) {

            return "You can search products from the Products "
                    + "page using the product name or category.";
        }


        return null;
    }


    /*
     * OPENAI AI RESPONSE
     */

    private String getAIResponse(String message)
            throws Exception {

        String apiKey =
                System.getenv("OPENAI_API_KEY");


        // No API key available

        if (apiKey == null ||
                apiKey.trim().isEmpty()) {

            return getFallbackResponse();
        }


        String model =
                System.getenv("OPENAI_MODEL");


        if (model == null ||
                model.trim().isEmpty()) {

            model = DEFAULT_MODEL;
        }


        HttpURLConnection connection = null;


        try {

            URL url =
                    new URL(OPENAI_URL);

            connection =
                    (HttpURLConnection) url.openConnection();


            connection.setRequestMethod("POST");

            connection.setRequestProperty(
                    "Authorization",
                    "Bearer " + apiKey
            );

            connection.setRequestProperty(
                    "Content-Type",
                    "application/json"
            );

            connection.setDoOutput(true);

            connection.setConnectTimeout(10000);

            connection.setReadTimeout(30000);


            /*
             * Create JSON request
             */

            JsonObject request =
                    new JsonObject();


            request.addProperty(
                    "model",
                    model
            );


            request.addProperty(
                    "instructions",
                    "You are the ShinyMart AI Assistant. "
                    + "Answer only questions related to ShinyMart, "
                    + "its products, sellers, buyers, cart, checkout, "
                    + "orders, reviews, login and registration. "
                    + "Keep answers short and simple. "
                    + "If the question is unrelated to ShinyMart, "
                    + "say: I can help only with ShinyMart questions."
            );


            request.addProperty(
                    "input",
                    message
            );


            String json =
                    gson.toJson(request);


            /*
             * Send request
             */

            try (OutputStream output =
                         connection.getOutputStream()) {

                byte[] input =
                        json.getBytes(StandardCharsets.UTF_8);

                output.write(input);
            }


            int responseCode =
                    connection.getResponseCode();


            InputStream inputStream;


            if (responseCode >= 200 &&
                    responseCode < 300) {

                inputStream =
                        connection.getInputStream();

            } else {

                inputStream =
                        connection.getErrorStream();
            }


            String responseBody =
                    readStream(inputStream);


            if (responseCode < 200 ||
                    responseCode >= 300) {

                System.out.println(
                        "OpenAI API response: "
                                + responseBody
                );

                return getFallbackResponse();
            }


            return extractResponseText(
                    responseBody
            );

        } finally {

            if (connection != null) {
                connection.disconnect();
            }
        }
    }


    /*
     * READ API RESPONSE
     */

    private String readStream(InputStream inputStream)
            throws IOException {

        if (inputStream == null) {
            return "";
        }


        StringBuilder result =
                new StringBuilder();


        try (BufferedReader reader =
                     new BufferedReader(
                             new InputStreamReader(
                                     inputStream,
                                     StandardCharsets.UTF_8
                             ))) {

            String line;

            while ((line = reader.readLine()) != null) {

                result.append(line);
            }
        }


        return result.toString();
    }


    /*
     * EXTRACT TEXT FROM RESPONSES API
     */

    private String extractResponseText(
            String responseBody) {

        try {

            JsonObject response =
                    JsonParser.parseString(responseBody)
                            .getAsJsonObject();


            /*
             * Usually available as output_text
             */

            if (response.has("output_text") &&
                    !response.get("output_text").isJsonNull()) {

                String text =
                        response.get("output_text")
                                .getAsString();

                if (!text.trim().isEmpty()) {
                    return text;
                }
            }


            /*
             * Fallback:
             * Read output -> content -> text
             */

            if (response.has("output")) {

                JsonArray output =
                        response.getAsJsonArray("output");


                for (int i = 0;
                     i < output.size();
                     i++) {

                    JsonObject item =
                            output.get(i)
                                    .getAsJsonObject();


                    if (!item.has("content")) {
                        continue;
                    }


                    JsonArray content =
                            item.getAsJsonArray("content");


                    for (int j = 0;
                         j < content.size();
                         j++) {

                        JsonObject part =
                                content.get(j)
                                        .getAsJsonObject();


                        if (part.has("text")) {

                            String text =
                                    part.get("text")
                                            .getAsString();

                            if (!text.trim().isEmpty()) {
                                return text;
                            }
                        }
                    }
                }
            }

        } catch (Exception e) {

            System.out.println(
                    "Error reading chatbot response: "
                            + e.getMessage()
            );
        }


        return getFallbackResponse();
    }


    /*
     * FALLBACK RESPONSE
     */

    private String getFallbackResponse() {

        return "I'm the ShinyMart assistant. "
                + "I can help with products, cart, checkout, "
                + "orders, reviews, login and registration.";
    }
            }
