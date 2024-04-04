import mysql.connector
import random
import string
import hvac
import smtplib
from dotenv import load_dotenv
import os
load_dotenv()
print(os.getenv("DATABASE_HOST"))
all_characters = string.ascii_letters + string.digits 
password = ''.join(random.choices(all_characters, k=16))
print(password)


try:
    db = mysql.connector.connect(
    host=os.environ["DATABASE_HOST"],
    user=os.environ["DATABASE_USER"],
    password=os.environ["DATABASE_PASSWORD"],
    db=os.environ["DATABASE_DB"]
    )

      
    cur = db.cursor()
    cur.execute(
    '''
        ALTER USER 'pallavi'@'localhost' IDENTIFIED BY %s
    ''',(password,)
)
except Exception as e:
    print("Database connection error",e)


def servser_connect():
    try:
        client = hvac.Client(
        url= os.environ["VAULT_URL"],
        token= os.environ["VAULT_TOKEN"]
        )
        client.secrets.kv.v2.create_or_update_secret (
            mount_point="kv",
            path = "management/heroku",
            secret = dict(pallavi=password),
        )
    # print(f"Client is authentiated:{client.is_authenticated()}")
    except Exception as e:
        print("Vault connection issue",e)

def sending_email():
    servser_connect()
    try:
        s = smtplib.SMTP('smtp.gmail.com', 587)
        s.starttls()
        s.login(os.environ["EMAIL_ID"], os.environ["EMAIL_ID_PASSWORD"])
        message = "Password is updated"
        s.sendmail(os.environ["EMAIL_ID"],"pramodh@sirpi.io", message)
    except Exception as e:
        print("Failed to send Email!" ,e)


if __name__ == "__main__":
    sending_email()
    

