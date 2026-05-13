package in.sp.main.Services;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class FileUploadService {

    private static final String BASE_UPLOAD_DIR = "C:/uploads/";

    public String saveFile(MultipartFile file, String folderName) throws IOException {

        if (file == null || file.isEmpty()) {
            return null; // allow registration without image
        }

        File folder = new File(BASE_UPLOAD_DIR + folderName);
        if (!folder.exists()) {
            folder.mkdirs();
        }

        String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
        File destination = new File(folder, fileName);

        file.transferTo(destination);

        // Path used in JSP
        return "/uploads/" + folderName + "/" + fileName;
    }
}
