Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486C0C7EE26
	for <webhook@archiver.kernel.org>; Tue,  2 May 2023 15:38:08 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.1465.1683041883939292390
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 May 2023 08:38:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=B2hZR9co;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-20230502153800a1060d409c02e8c7ee-o0x1gm@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20230502153800a1060d409c02e8c7ee
        for <cip-dev@lists.cip-project.org>;
        Tue, 02 May 2023 17:38:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=OyZjQdNrnGEgxybFXh2HNb9GUmL5aHuujuFD8HYsQE8=;
 b=B2hZR9coRm5Sydc8D7ecICJedrT+szLDTww5CTD+34+zjgorZuviGpG3Bzgfqe4fpKOYO+
 yE4Ro05xUe0vm8Z7m2Fsb41oI1a9UcN91S9mVc3tdseGEcR4sTJ3htrg2RLB5vX5GJr0ehLc
 yZEWr7LjOUpDMA/eNtKwJCw7yNmGE=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4 1/7] secure-boot-secrets: Use distro specific snakeoil certs and keys
Date: Tue,  2 May 2023 17:37:53 +0200
Message-Id: <20230502153759.1284906-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230502153759.1284906-1-Quirin.Gylstorff@siemens.com>
References: <20230502153759.1284906-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 May 2023 15:38:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11381

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This fixes the boot of Debian buster(10) with secure boot enabled.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../secure-boot-secrets/files/bookworm        |  1 +
 .../files/{ => bullseye}/PkKek-1-snakeoil.key |  0
 .../files/{ => bullseye}/PkKek-1-snakeoil.pem |  0
 .../files/buster/PkKek-1-snakeoil.key         | 28 +++++++++++++++++++
 .../files/buster/PkKek-1-snakeoil.pem         | 19 +++++++++++++
 .../secure-boot-snakeoil_0.1.bb               |  4 +--
 6 files changed, 50 insertions(+), 2 deletions(-)
 create mode 120000 recipes-devtools/secure-boot-secrets/files/bookworm
 rename recipes-devtools/secure-boot-secrets/files/{ => bullseye}/PkKek-1-snakeoil.key (100%)
 rename recipes-devtools/secure-boot-secrets/files/{ => bullseye}/PkKek-1-snakeoil.pem (100%)
 create mode 100644 recipes-devtools/secure-boot-secrets/files/buster/PkKek-1-snakeoil.key
 create mode 100644 recipes-devtools/secure-boot-secrets/files/buster/PkKek-1-snakeoil.pem

diff --git a/recipes-devtools/secure-boot-secrets/files/bookworm b/recipes-devtools/secure-boot-secrets/files/bookworm
new file mode 120000
index 0000000..2b77534
--- /dev/null
+++ b/recipes-devtools/secure-boot-secrets/files/bookworm
@@ -0,0 +1 @@
+bullseye/
\ No newline at end of file
diff --git a/recipes-devtools/secure-boot-secrets/files/PkKek-1-snakeoil.key b/recipes-devtools/secure-boot-secrets/files/bullseye/PkKek-1-snakeoil.key
similarity index 100%
rename from recipes-devtools/secure-boot-secrets/files/PkKek-1-snakeoil.key
rename to recipes-devtools/secure-boot-secrets/files/bullseye/PkKek-1-snakeoil.key
diff --git a/recipes-devtools/secure-boot-secrets/files/PkKek-1-snakeoil.pem b/recipes-devtools/secure-boot-secrets/files/bullseye/PkKek-1-snakeoil.pem
similarity index 100%
rename from recipes-devtools/secure-boot-secrets/files/PkKek-1-snakeoil.pem
rename to recipes-devtools/secure-boot-secrets/files/bullseye/PkKek-1-snakeoil.pem
diff --git a/recipes-devtools/secure-boot-secrets/files/buster/PkKek-1-snakeoil.key b/recipes-devtools/secure-boot-secrets/files/buster/PkKek-1-snakeoil.key
new file mode 100644
index 0000000..b9e42c7
--- /dev/null
+++ b/recipes-devtools/secure-boot-secrets/files/buster/PkKek-1-snakeoil.key
@@ -0,0 +1,28 @@
+-----BEGIN PRIVATE KEY-----
+MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDNQOknAPMOkujb
+K1VFKC39BZFiT9iNp7l9u6OK2rvddgu4Nn79Z/lTrOk5/J/Nf+XlHQoJX1dhQkXj
+tASY0KehamDdxF1GvL7cUhi12c0rXnUBnYvvg4jiwxfVqRIT4x9kWB08Vyb6fS4m
+BC69FgbJhpHo3XBuEn/aI45tr6xsrJxoqIvV9KOKnZyuIcD/TlxhKiZ1RP6tNRkA
+sV0JC45T6BfxGqGZ9ujxUQTsykTeeu8ehxAAWmHJiAbyNp2OCDKYTuxARkasGo6v
+AwMeK1umgY2U4jZV0WAvmNEoe4HrWIKSpOZJa5LiVs4QmaazqGFCdOe7/Irs7c0R
+Z6AA8yu1AgMBAAECggEBAKUb9THx+pObrAM6TYKvOqdSBkxubIYvCPDSs1EseXlB
+z1WlSOwx6ofcDVUfGbGmk9mFTaCSeGj9ddkg453GI0Ken0NmBZ60kFgNFmGazgd4
+GWluQbYvOjsnsxGlyqwCxSrkEsiKVwmjDy93p91lTZppTRBkqV9yNDTW62jiqzJT
+CzWimHWyPlK7MjfOyV/X/GD8rugr0F/ikugzVJXCIuhnO62ouU1Imo+Agb3jJM5h
+26CWerha8Nd6z6lvHM0g014gzL40JrxehqOkYp/6VF6qX37sTHyAw9J4RUQROC/L
+L+XYAAQZMv3GBJhkn6FOBlKuBmJLw01mTKXuNyGf1EECgYEA6cShh7uPJHeqqHpm
+ddt0DBgwFueH3pXPv1a6sDBt8P3PJ376p8X1QpoL30sZYc+cEXJcicoaq5NqrkJA
+NltHg00sHqyfEfaDS2sr38e5qWoD41BsFdbNmfe2SaunXmSZ7d/QD810l+UaRNCR
+doZcmeCFpcXRs0N1nc2C0w+Ya/ECgYEA4MYPCZ43lB1qeShUcaY/WFiWnJrNdoJR
+p9S7xhPAqpXmG19utc+geTvN+y8YqOVg1ICaXpfYV7BG7VdD3mLQTIxdai98Rl4r
+EBKrSGV6cyXkghaGeZHL2M9/FLxCZrfEpbzl82kacCJHCaiQiu9IVTsOabwoW68x
+Evfz1FHaEAUCgYAmPrc2n6bhjnprKetNaOPpfqOPe72s2tGsOiI85Q93l+6mRY34
+mNhxVwaON5kleXPNHuqo2FnYrDuN2uTqf7CJeLy5IAC+TZhZZGU/LUvgval5LRUh
+1Yy5nd9C2kR9mvPcCPvfOfvTRfYwP/csbvsDacozvtN6ApVhhdfbc/e54QKBgFZV
+PGlhT8+gDMlEaErOo/326MJ14vzlyR9BYm4OIC5lLODOouNKQETQZ6lWyY31rF9y
+ldhHUl0748I9hl/gbEk6kJa8bmtIuBmQUiGYeJPJth8RL8155mX8LL92H7r8Upem
+GlyHvhPb1pUrHXl/trSl3j9WedndTGgQvKKMXclRAoGBAKCwevyJrlhnvbZQzjyV
+zWPyy3028370nsTYnOBh2yVtPThcOCewp9THEy0FAVkMYqE1sdpAN51PdD5UPGFo
+RkXd/5HQTSDkVGHhO7VohXM/H/nNQgtotoDRSMkxTymQTHad5LNesi3dCEqa1gTC
+gyh89dCjF1p+mnLi0xITtkoA
+-----END PRIVATE KEY-----
diff --git a/recipes-devtools/secure-boot-secrets/files/buster/PkKek-1-snakeoil.pem b/recipes-devtools/secure-boot-secrets/files/buster/PkKek-1-snakeoil.pem
new file mode 100644
index 0000000..73936f7
--- /dev/null
+++ b/recipes-devtools/secure-boot-secrets/files/buster/PkKek-1-snakeoil.pem
@@ -0,0 +1,19 @@
+-----BEGIN CERTIFICATE-----
+MIIDCTCCAfGgAwIBAgIUSbJC1oRCJUbGkwfWHscBeZrRHZcwDQYJKoZIhvcNAQEL
+BQAwFDESMBAGA1UECgwJU25ha2UgT2lsMB4XDTE5MTEwMTIyMDI1NVoXDTE5MTIw
+MTIyMDI1NVowFDESMBAGA1UECgwJU25ha2UgT2lsMIIBIjANBgkqhkiG9w0BAQEF
+AAOCAQ8AMIIBCgKCAQEAzUDpJwDzDpLo2ytVRSgt/QWRYk/Yjae5fbujitq73XYL
+uDZ+/Wf5U6zpOfyfzX/l5R0KCV9XYUJF47QEmNCnoWpg3cRdRry+3FIYtdnNK151
+AZ2L74OI4sMX1akSE+MfZFgdPFcm+n0uJgQuvRYGyYaR6N1wbhJ/2iOOba+sbKyc
+aKiL1fSjip2criHA/05cYSomdUT+rTUZALFdCQuOU+gX8Rqhmfbo8VEE7MpE3nrv
+HocQAFphyYgG8jadjggymE7sQEZGrBqOrwMDHitbpoGNlOI2VdFgL5jRKHuB61iC
+kqTmSWuS4lbOEJmms6hhQnTnu/yK7O3NEWegAPMrtQIDAQABo1MwUTAdBgNVHQ4E
+FgQUFD7OXb2T6sOysRo3hj2f15SX8I8wHwYDVR0jBBgwFoAUFD7OXb2T6sOysRo3
+hj2f15SX8I8wDwYDVR0TAQH/BAUwAwEB/zANBgkqhkiG9w0BAQsFAAOCAQEANZRB
+NFVUVZVehpj3QGbbSjp77m0V6JrEYn6u/XjLRFsUNw5Hh35UCR0HkKZ0cLgrVKb/
+8yL6LaYLOY6yDwEFWMtLXiF2S4noO8raEgW6A7DHawb2Y4ZNFRO4oBkyWbtd36Uu
+UfSszs2av048wb5J/pNedRSx8I/FiCNWummzpkBHzx023TdLPd8fmkmG7ZBpStN0
+Y//EE4DKTfHxAwt5w7WdZF5EY/KHPopnR+WSrdutRIK6zT+/+vKihtHYZbrv+7Ap
+K7xOM/zJ6E9vUROmuOhL3YL3MuLn5qHEvhM0eMxEAlCnSJlFkQE4/RXhDpZJYbR7
+x+PQllgoo4H6W30Dew==
+-----END CERTIFICATE-----
diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.1.bb b/recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.1.bb
index 24a5352..a446987 100644
--- a/recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.1.bb
+++ b/recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.1.bb
@@ -11,7 +11,7 @@
 
 require secure-boot-secrets.inc
 
-SB_KEY = "PkKek-1-snakeoil.key"
-SB_CERT = "PkKek-1-snakeoil.pem"
+SB_KEY = "${BASE_DISTRO_CODENAME}/PkKek-1-snakeoil.key"
+SB_CERT = "${BASE_DISTRO_CODENAME}/PkKek-1-snakeoil.pem"
 
 DEBIAN_CONFLICTS = "secure-boot-key"
-- 
2.39.2


