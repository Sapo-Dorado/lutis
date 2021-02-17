export async function setUsername(email, token, username) {
  let data = {
    email: email,
    token: token,
    username: username
  }
  let headers = {
    method: "POST",
    body: JSON.stringify(data),
    headers: {"Content-type": "application/json; charset=UTF-8"}
  }
  let response = await fetch("/api/username", headers)
  let json = await response.json()
  return json
}

export async function getPosts() {
  let headers = {
    method: "GET",
    headers: {"Content-type": "application/json; charset=UTF-8"}
  }
  let response = await fetch("/api/posts", headers)
  let json = await response.json()
  return json
}