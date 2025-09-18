#!/usr/bin/env python3
import asyncio
from deimos_router import Router, chat
from deimos_router.rules import AutoTaskRule, MessageLengthRule
from flask import Flask
from flask import jsonify, request

# requires the rest of Martian API's Deimos Router code to run, which has not been copied over to this repo
# https://github.com/withmartian/deimos-router

def create_auto_task_router():
    """Create a router that automatically detects tasks from message content."""

    message_length_rule = MessageLengthRule(
        name = "msg-len",
        short_threshold = 50,
        long_threshold = 200,
        short_model = "openai/gpt-5-nano",
        medium_model = "anthropic/claude-3-5-sonnet",
        long_model = "openai/gpt-5-mini"
    )

    
    auto_task_rule = AutoTaskRule(
        name = "auto-task-rule",
        triggers = {
            "creative writing" : "openai/gpt-5-nano",
            "sentiment analysis" : "openai/gpt-5-nano",
            "informational" : "openai/gpt-5-mini",
            "haiku composition" : "openai/gpt-5-nano",
            "open questions": message_length_rule
        },
    )

    # context_rule = ConversationContextRule(
    #     name = "conv-context-rule",
    #     new_threshold = 3,
    #     deep_threshold = 10,
    #     new_model = "openai/gpt-5-nano",
    #     developing_model = "openai/gpt-4o-mini",
    #     deep_model = "openai/gpt-4o"
    # )

    
    # Create and configure the router
    router = Router(
        name = "auto-router",
        rules = [auto_task_rule],
        default="openai/gpt-4o-mini"
    )
    return router

async def test_auto_task_routing(request):

    print(request)
    
    # Create the router
    router = create_auto_task_router()
    
    # Use the router for chat completions
    response1 = chat.completions.create(
        model="deimos/auto-router",
        messages=[
            {"role": "user", "content": request}
        ]
    )
	
    return response1.choices[0].message.content

app = Flask(__name__)


@app.route("/api/answers", methods=['POST'])
def post_answer():
    data = request.get_json()

    prompt = """
    Happy (molamola), Sad (Guppy), Lonely (Dab), Neutral (Koi), Confident (Lionfish), Stressed (clownfish), Angry (triggerfish), Excited (goldfish) 
    Using real facts about these fish as well as the emotion assigned to them, tell me which fish I should be assigned based on this journal entry. 
    You can list multiple fish, but it must be justified. Pick only up to 3. Be creative. 
    Make sure your entry is formatted like: 
    Fish: reason \n Fish: reason \n
    ...Here is the journal entry: 
    """ + data.get("text", "")

    result = asyncio.run(test_auto_task_routing(prompt))
    if result != "":
        return jsonify({"status": 200, "answer": result})
    else:
        return jsonify({"status": 404, "message": "No answer."})

