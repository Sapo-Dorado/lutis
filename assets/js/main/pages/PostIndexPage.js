import React from "react"
import UserInfo from "../utils/UserInfo"

export default class PostIndexPage extends React.Component {
  render() {
    return (
      <>
        <p>Welcome, {UserInfo.getEmail()}</p>
        <p>Loading posts...</p>
      </>
    )
  }
}