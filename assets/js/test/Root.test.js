import Root from "../Root"
import React from "react"
import { render } from '@testing-library/react'
import '@testing-library/jest-dom/extend-expect'

const exampleEmail = "test@example.com"
const exampleToken = "exampleToken"


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
      } else {
        return key
      }
    })
  const { getByText } = render(<Root />)
  expect(getByText(`Welcome, ${exampleEmail}`)).toBeInTheDocument()
})