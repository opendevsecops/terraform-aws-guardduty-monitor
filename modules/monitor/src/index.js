const url = require('url')
const https = require('https')
const awsSdk = require('aws-sdk')

const ses = new awsSdk.SES()

const send = async (from, to, subject, body) => {
    return ses.sendEmail({
        Source: from,

        Destination: {
            ToAddresses: [
                to
            ]
        },

        Message: {
            Subject: {
                Charset: 'UTF-8',
                Data: subject
            },

            Body: {
                Text: {
                    Charset: 'UTF-8',
                    Data: body
                }
            }
        }
    }).promise()
}

const post = async (uri, body) => {
    body = JSON.stringify(body)

    const options = url.parse(uri)

    options.method = 'POST'

    options.headers = {
        'Content-Type': 'application/json',
        'Content-Length': body.length
    }

    return new Promise((resolve, reject) => {
        const req = https.request(options, (res) => {
            if (res.statusCode === 200) {
                res.on('end', () => {
                    resolve()
                })
            } else {
                reject(new Error(`Unexpected status code: ${res.statusCode}`))
            }
        })

        req.on('error', (error) => {
            reject(error)
        })

        req.end(body)
    })
}

exports.handler = async (event) => {
    console.log(event)

    const { title='', description='' } = event
    
    if (process.env.SLACK_NOTIFICATION_URL) {
        console.log('Sending slack notification')

        const text = `*${title}*\n${description}`

        try {
            await post(process.env.SLACK_NOTIFICATION_URL, {text})
        } catch (e) {
            console.error(e)
        }

        console.log('Slack notification sent')
    }
}
