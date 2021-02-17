import React from "react"
import UserInfo from "../utils/UserInfo"
import { getPosts } from "../utils/Util"

export default class PostPage extends React.Component {
  render() {
    getPosts().then(data => console.log(data))
    return (
      <>
        <p>Welcome, {UserInfo.getEmail()}</p>
        <p>Loading Posts...</p>
      </>
    )
  }
}