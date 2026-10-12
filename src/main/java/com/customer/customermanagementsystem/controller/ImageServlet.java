package com.customer.customermanagementsystem.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.file.Files;

@WebServlet("/image")
public class ImageServlet extends HttpServlet {

    private static final String UPLOAD_PATH = "D:/CustomerUploads";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //Read the filename from the url
        String fileName = request.getParameter("file");

        //Check if the filename is null
        if (fileName == null || fileName.isEmpty()){
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        //Create java file object
        File imageFile = new File(UPLOAD_PATH, fileName);

        //checks whether the file actually exist and if not send 404 not found error
        if (!imageFile.exists()){
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        //Get the MIME type of the file based on its extension
        String mimeType = getServletContext().getMimeType(imageFile.getName());

        //if the file type cant detemine, then use binary file mime type
        if (mimeType == null){
            mimeType = "application/octet-stream";
        }

        //Set the image type
        response.setContentType(mimeType);

        //Copy the image file contents to the HTTP response output stream
        Files.copy(imageFile.toPath(), response.getOutputStream());

    }

}
