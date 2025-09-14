extends HTTPRequest

@onready var http_request: HTTPRequest = $"."


func sentiment_analysis(body):
	var url = "http://127.0.0.1:5000/api/answers"
	#http_request.request("http://127.0.0.1:5000/api/answers")
	
	# Create a dictionary with your data
	var payload = {"text": body}
	
	# Convert dictionary to JSON string
	var json_body = JSON.stringify(payload)
	
	# Set headers
	var headers = ["Content-Type: application/json"]
	
	var error = http_request.request(url, PackedStringArray(headers), HTTPClient.METHOD_POST, json_body)
	
	if error != OK:
		print("Request error:", error)
	
