# File Processing App

This is a simplified Ruby application designed to process image and PDF files. It extracts previews for image/PDF files and extracts text from PDFs, saving the output to the application root folder.

## Features

- **Preview**: Generates an image preview for image or PDF files and saves it as a `.preview.png` file.
- **Text Extraction**: Extracts text from PDF files and saves the text in a `.txt` file.
- **CLI Options**: Accepts file input and command options via the command line interface.

## Prerequisites

- Ruby (version 2.6+ recommended)
- Bundler (for managing dependencies)
- Docker (optional, for running the app in a containerized environment)

## Installation

1. Clone this repository to your local machine:

  ```
		git clone https://github.com/yourusername/file-processing-app.git
		cd file-processing-app
	```

2. Install dependencies:

	```
		bundle install
	```

# Usage
The application accepts two main arguments:

- f: Path to the input file (image, PDF, etc.)
- c: Command to specify what operation to perform (preview, text, or all)

## Command Line Interface
1. Generate Preview:

	```
		ruby app.rb -f test-file.pdf -c preview
		This will generate an image preview for the test-file.pdf (if the file is a PDF or image).
	```

2. Extract Text:

	```
		ruby app.rb -f test-file.pdf -c text
		This will extract text from the PDF file and save it as a .txt file in the root directory.
	```

3. Run Both Operations:

	```
		ruby app.rb -f test-file.pdf -c all
	```

This will both generate a preview and extract text from the file.

## Example:

	```
		ruby app.rb -f test-file.pdf -c all
	```
This will:

- Create a preview for the test-file.pdf (saved as test-file.preview.png).
- Extract text from the PDF and save it as test-file.txt.

## Running Tests
This application uses RSpec for testing. You can run the tests using the following command:

	```
		bundle exec rspec
	```
This will run all the tests defined in the spec directory. If any tests fail, you’ll get detailed output in the console.

# Dockerization
This application can be run within a Docker container. To run the application in Docker, follow these steps:

- Build the Docker image:

	```
		docker build -t file-processing-app .
	```

- Run the Docker container:

	```
		docker run -v $(pwd):/app file-processing-app ruby app.rb -f test-file.pdf -c all
	```
This mounts your current directory to the /app directory in the container and runs the application.

## License
This project is licensed under the MIT License - see the LICENSE file for details.
