import Root from "../Root"
import React from "react"
import { render } from "@testing-library/react"
import "@testing-library/jest-dom/extend-expect"

const exampleEmail = "test@example.com"
const exampleToken = "exampleToken"
const exampleUsername = "exampleUsername"


test('Renders welcome message', () => {
  const {getByText} = render(<Root />)
  expect(getByText("Welcome to Lutis!")).toBeInTheDocument()
});

test('renders post index page when user info is provided', () =>{
  jest.spyOn(URLSearchParams.prototype, "get")
    .mockImplementation(key => {
      if(key === "email") {
        return exampleEmail
      } else if(key === "token") {
        return exampleToken
      } else if (key == "username") {
        return exampleUsername
      }
    })
  const { getByText } = render(<Root />)
  expect(getByText(`Welcome, ${exampleEmail}`)).toBeInTheDocument()
})

test('renders username page when user info is missing a username', () => {
  jest.spyOn(URLSearchParams.prototype, "get")
    .mockImplementation(key => {
      if(key === "email") {
        return exampleEmail
      } else if(key === "token") {
        return exampleToken
      } else {
        return ""
      }
    })
    const { getByText } = render(<Root />)
    expect(getByText("Enter a username:")).toBeInTheDocument()
})