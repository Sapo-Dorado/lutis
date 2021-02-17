import React from "react"
import UserInfo from "../utils/UserInfo"
import { setUsername } from "../utils/Util"

export default class UsernamePage extends React.Component {
  constructor(props) {
    super(props)

    this.state = {value: "", error: null}
    
    this.handleChange = this.handleChange.bind(this)
    this.handleSubmit = this.handleSubmit.bind(this)
  }

  handleChange(event) {
    this.setState({value: event.target.value})
  }

  handleSubmit(event) {
    setUsername(UserInfo.getEmail(), UserInfo.getToken(), this.state.value).then(result => {
      if(result.errors !== undefined) {
        if(result.errors.username !== undefined){
          this.setState({error: result.errors.username})
        } else {
          window.location.href="/"
        }
      } else {
        UserInfo.setUsername(result.data.username)
        window.location.href =`/?email=${UserInfo.getEmail()}&token=${UserInfo.getToken()}&username=${UserInfo.getUsername()}`
      }
    })
    event.preventDefault()
  }


  render() {
    let error = null
    if(this.state.error !== null) {
      error = <p>{this.state.error}</p>
    }
    return (
      <form onSubmit={this.handleSubmit}>
        <label>
          Enter a username:
          <input type="text" value={this.state.value} onChange={this.handleChange} />
        </label>
        {error}
        <input type="submit" value="Enter" />
      </form>
    )
  }
}