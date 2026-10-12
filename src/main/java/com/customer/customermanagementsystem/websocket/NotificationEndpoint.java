package com.customer.customermanagementsystem.websocket;

import jakarta.websocket.OnClose;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;

import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;

@ServerEndpoint("/notifications")
public class NotificationEndpoint {

    private static final Set<Session> sessions = new CopyOnWriteArraySet<>();

    @OnOpen
    public void onOpen(Session session) {

        //extract the client id from the url's query parameters
        //Get the list associate with the clientId and get the first value in that list
        String clientId = session.getRequestParameterMap().get("clientId").get(0);

        //Attached the clientId
        session.getUserProperties().put("clientId", clientId);

        //Add it to the sessions
        sessions.add(session);

        System.out.println("connected:" + session.getId());

    }

    @OnClose
    public void onClose(Session session) {

        sessions.remove(session);
        System.out.println("disconnected:" + session.getId());
    }

    public static void broadcast(String message, String senderClient) {

        //Loop through every single open browser tab
        for (Session session : sessions) {
            //If the session is closed, skip it
            if (!session.isOpen()) {
                continue;
            }

            //Extract the clientId
            String clientId = (String) session.getUserProperties().get("clientId");

            //If this client ID match the sender's ID then skip
            if (senderClient.equals(clientId)) {
                continue;
            }

            try {
                //sent the msg to the user's browser
                session.getBasicRemote().sendText(message);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
