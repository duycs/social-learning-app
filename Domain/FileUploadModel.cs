namespace QAP4.Domain
{
    public class FileUploadModel
    {
        public bool Success { get; set; }
        public string Url { get; set; }
        public string PreSignedURL { get; set; }
        public string FileName { get; set; }
        public string FileExtension { get; set; }
    }
}