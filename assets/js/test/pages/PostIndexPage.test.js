import React from "react"
import { render } from '@testing-library/react'
import '@testing-library/jest-dom/extend-expect'
import PostIndexPage from "../../main/pages/PostIndexPage";
import UserInfo from "../../main/utils/UserInfo";

const exampleEmail = "test@email.com"
const exampleToken = "exampleToken"

beforeAll(() => {
  UserInfo.setEmail(exampleEmail)
  UserInfo.setToken(exampleToken)
})

test('Renders welcome message for the users email', () => {
  const {getByText} = render(<PostIndexPage />)
  expect(getByText("Welcome, test@email.com")).toBeInTheDocument()
});