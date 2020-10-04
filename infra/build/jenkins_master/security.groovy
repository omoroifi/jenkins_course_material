import jenkins.model.*
import hudson.security.*

def instance = Jenkins.getInstance()
def hudsonRealm = new HudsonPrivateSecurityRealm(false)

File credsFile = new File(System.getenv('USER_CREDS'))
Properties creds = new Properties()
credsFile.withInputStream {
    creds.load(it)
}

hudsonRealm.createAccount(creds.USERNAME, creds.PASSWORD)
instance.setSecurityRealm(hudsonRealm)
instance.save()

def strategy = new hudson.security.FullControlOnceLoggedInAuthorizationStrategy()
strategy.setAllowAnonymousRead(false)
instance.setAuthorizationStrategy(strategy)
