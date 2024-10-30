import base64

def image_to_base64(image_path):
    try:
        with open(image_path, "rb") as img_file:
            # Read the image file in binary mode
            image_data = img_file.read()
            # Encode the binary data using base64
            base64_data = base64.b64encode(image_data)
            # Decode bytes-like object to ASCII string
            base64_string = base64_data.decode("utf-8")
            return base64_string
    except FileNotFoundError:
        print("File not found.")
        return None

# Example usage
if __name__ == "__main__":
    image_path = "example_image.jpg"  # Change this to your image file path
    base64_string = image_to_base64('I:\\FYP\\FYP\\serverside\\media\\12240346_782876231838806_193618679774322830_o.jpg')
    if base64_string:
        print("Base64 String:\n")
        print(base64_string)
        print("\n\n String:\n")
