# API v1

 - Supported formats: JSON
 - Supported authentication: OAuth 2.0

## Resources


### Posts

#### List all posts: `GET /posts`

 - Parameters:
    - **ids**: optional (default all ids)
    - **fields**: optional (default all fields)
    - **query**: optional (default to "")
    - **limit**: optional (default is 10)
    - **offset**: optional (default is 0)
    
##### Example:

    GET /posts?query=interesting+post
    
Sample response:
    
    {
        posts: [
            {
                id: 1,
                title: 'An interesting post',
                body: 'Some interesting content'
                created: ,
                updated: ,
                author: 1
            },
            {
                id: 2,
                title: 'Another interesting post',
                body: 'Some other interesting content',
                created: ,
                updated: ,
                author: 1
            }
        ],
        total: 2,
        limit: 10,
        offset: 0
    }

#### Get a post: `GET /posts/:id`

 - Parameters:
    - **fields**: optional (default all fields)
    
##### Example:

    GET /posts
    
Sample response:
    
    {
        id: 1,
        title: 'An interesting post',
        body: 'Some interesting content',
        created: ,
        updated: ,
        author: 1
    }
    
#### Create a post: `POST /posts`

- Parameters:
    - **title**: mandatory (string)
    - **body**: mandatory (string)
    
#### Edit a post: `PUT /posts/:id`

- Parameters:
    - **title**: string
    - **body**: string
    
#### Delete a post: `DELETE /posts/:id`

##### Example:

    DELETE /posts/1


### Authors

#### List all authors: `GET /authors`

 - Parameters:
    - **ids**: optional (default all ids)
    - **fields**: optional (default all fields)
    - **limit**: optional (default is 10)
    - **offset**: optional (default is 0)
    
##### Example:

    GET /authors?ids=1,2&fields=firstName,lastName,id
    
Sample response:

    {
        authors: [
            {
                id: 1,
                firstName: 'Daniel',
                lastName: 'Salmeron Amselem',
                posts: [1,2,3]
            },
            {
                id: 2,
                firstName: 'Elad',
                lastName: 'Maimon',
                posts: [4,5,6]
            }
        ],
        total: 5,
        limit: 10,
        offset: 0
    }

#### Get an author: `GET /authors/:id`

 - Parameters:
    - **fields**: optional (default all fields)
    
##### Example:

    GET /authors/1
    
Sample response:

    {
        id: 1
        firstName: 'Daniel',
        lastName: 'Salmeron Amselem',
        posts: [1,2,3]
    }


## OAuth authentication

1. The client is redirected to a provider specified by the server. (eg. Google OAuth)
2. The provider asks the client to give permissions to the server.
3. The provider sends an HTTP request to the server with an access token.
4. The server sends an HTTP request to the provider with the access token to validate the user.
5. The provider responds with a VALID or INVALID access token.
6. The server reacts accordingly.

### How to apply this authentication to an API?

Manual steps for the API consumer:

1. Get an access token from the OAuth provider. [HOWTO]

Automatic steps:

1. The API consumer has to provide the access token in every single request to the API.
2. The API provider will use the access token and validate it against the access token provider.
3. React according to the response from the provider.

