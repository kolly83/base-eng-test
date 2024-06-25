import sys
import os
import unittest
import json
from aws_lambda_powertools.utilities.typing import LambdaContext

# Ensure the src directory is in the path!
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'src')))

from main import lambda_handler  # Import the lambda_handler function

class CustomLambdaContext:
    def __init__(self):
        self.function_name = "test_function"
        self.memory_limit_in_mb = 128
        self.invoked_function_arn = "arn:aws:lambda:us-west-2:123456789012:function:test_function"
        self.aws_request_id = "test_request_id"

class TestLambdaHandler(unittest.TestCase):

    def create_lambda_context(self):
        return CustomLambdaContext()

    def test_lambda_handler_how_are_you(self):
        event = {"body": '{"question": "How are you?"}'}
        context = self.create_lambda_context()
        response = lambda_handler(event, context)
        expected_response = {
            'statusCode': 200,
            'headers': {
                'Content-Type': 'application/json'
            },
            'body': json.dumps("I am fine, thank you!")
        }
        self.assertEqual(response, expected_response)

    def test_lambda_handler_whats_your_name(self):
        event = {"body": '{"question": "Whats your name?"}'}
        context = self.create_lambda_context()
        response = lambda_handler(event, context)
        expected_response = {
            'statusCode': 200,
            'headers': {
                'Content-Type': 'application/json'
            },
            'body': json.dumps("My name is Lambda!")
        }
        self.assertEqual(response, expected_response)

    def test_lambda_handler_how_old_are_you(self):
        event = {"body": '{"question": "How old are you?"}'}
        context = self.create_lambda_context()
        response = lambda_handler(event, context)
        expected_response = {
            'statusCode': 200,
            'headers': {
                'Content-Type': 'application/json'
            },
            'body': json.dumps('I am 00001 year old!')
        }
        self.assertEqual(response, expected_response)

    def test_lambda_handler_where_are_you_from(self):
        event = {"body": '{"question": "Where are you from?"}'}
        context = self.create_lambda_context()
        response = lambda_handler(event, context)
        expected_response = {
            'statusCode': 200,
            'headers': {
                'Content-Type': 'application/json'
            },
            'body': json.dumps('I am from the Amazonian Jungles of Seattle, Washington')
        }
        self.assertEqual(response, expected_response)

    def test_lambda_handler_favourite_colour(self):
        event = {"body": '{"question": "What is your favourite Colour?"}'}
        context = self.create_lambda_context()
        response = lambda_handler(event, context)
        expected_response = {
            'statusCode': 200,
            'headers': {
                'Content-Type': 'application/json'
            },
            'body': json.dumps('My favourite colour is Yellow')
        }
        self.assertEqual(response, expected_response)

    def test_lambda_handler_favourite_pet(self):
        event = {"body": '{"question": "What is your favourite pet?"}'}
        context = self.create_lambda_context()
        response = lambda_handler(event, context)
        expected_response = {
            'statusCode': 200,
            'headers': {
                'Content-Type': 'application/json'
            },
            'body': json.dumps('My favourite pet is tiger.')
        }
        self.assertEqual(response, expected_response)

    def test_lambda_handler_unknown_question(self):
        event = {"body": '{"question": "What is the capital of France?"}'}
        context = self.create_lambda_context()
        response = lambda_handler(event, context)
        expected_response = {
            'statusCode': 400,
            'headers': {
                'Content-Type': 'application/json'
            },
            'body': json.dumps({
                'error': "I'm sorry I don't understand the question.",
                'acceptedOptions': [
                    "How are you?",
                    "Whats your name?",
                    "How old are you?",
                    "Where are you from?",
                    "What is your favourite Colour?"
                    "What is your favourite pet?"
                ]
            })
        }
        self.assertEqual(response['statusCode'], expected_response['statusCode'])
        self.assertEqual(response['headers'], expected_response['headers'])
        self.assertEqual(json.loads(response['body']), json.loads(expected_response['body']))

if __name__ == '__main__':
    unittest.main()
