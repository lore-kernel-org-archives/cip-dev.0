Return-Path: <theflamefire89@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E58FC36008
	for <webhook@archiver.kernel.org>; Sun, 23 Mar 2025 08:21:54 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.web10.12444.1742718112569940894
 for <cip-dev@lists.cip-project.org>;
 Sun, 23 Mar 2025 01:21:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ThKXpIX7;
 spf=pass (domain: gmail.com, ip: 209.85.218.44, mailfrom: theflamefire89@gmail.com)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso531707266b.1
        for <cip-dev@lists.cip-project.org>; Sun, 23 Mar 2025 01:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742718111; x=1743322911; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVDRQUNy1HEHU7dRQIt444l/QbExM8isFxZVh4ur7P4=;
        b=ThKXpIX7w5AbKdPGJei79BZPH2gPn88nOQ4VhDDiXO8pXPpmLPuDF2zQLCmAY2Nz3X
         nJUESpbx+Dn5KRvcG2cIhSVFC3eQDSpAZd+e1nOo66OHMe5MlnStKkWv25g7Hf7sEhao
         KlSOcBEp2gA/E832wFF9kyCEfoFPLoOXYFNtBBdFLrE8hmNx8KJ6pnNfiEA0mqqzpSZ7
         i3uHw4ZYeN9DzEcYdIYX5u84mQqqmu4c619FncKvOXuFkwBAzPp637+hBa8DnwOkmKTW
         Bcsjrse95o4vtG5euEDVsx7dPGj3yBepFkHeTABUWbwZzfhSaZhJslTBLuY5ciO+sA0c
         j2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742718111; x=1743322911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UVDRQUNy1HEHU7dRQIt444l/QbExM8isFxZVh4ur7P4=;
        b=Y14qN+vsjYb8LL/uEDcOJ2ekoVoz/cqDfhfmbfO6p4ytQ7KhWHA9HCW+K+zZSbF6AC
         EOzxgqmJdJQ23xXj9kqBqWjeRd+UWRk7tiiqW6NkHkUcru8Jfjq2DSgtU2qmrAVV95+J
         Jot8otxbKYWUYJXakuh6O/4yHpG7lAnHhRrkK6HdMI5WhOSv9Oimc09i6ycXSPnGTDPP
         fSfX6e23N4FudxIiy/ftoWWvpcTtE7Pl9z0zXS1teAFvu96otnj/m2anV2LfW2cU8vow
         yiBZIdKTLFu/f672YfRJ0pn8TFYH7Mkeh83dcIrdHX7vxaOHaFPKIuuFsjeUWnopxkOC
         5xBg==
X-Gm-Message-State: AOJu0YyIbe8tjsyQY7ZC19A7VVCqBpuA3vrJQyW0kjTC+Z0JAbpjeTkR
	TmR1h3V5QMp230LDZKk0bWBiCmBipsAmAhHLItI/HJwmrT3w1f9kqpoJSA==
X-Gm-Gg: ASbGncs2Q4InGDbrxH/TOTp9g8K6FPOdElFRidVQzO73lom73XmotW7KXVCQwoNinQX
	AyiGSD69Z+zNbZ9svkcwXCUXNJQ38DuorE050sxYZVSV5xrGVuSpxNIHRUjaiL70popMhayLQF0
	XbIIuzzmHNl+uEnk9MB0Ckzb/m3e82zn0TVuGuIVYkZS46rtaWkcYhYECr8JLjU/WMoKreB4MLk
	n3wMg7yILQiSPzx3EBGy4rv2Szyf8KvVCPp50B3gKtlAq8VN4qkEp47eWoFRCi+vTU4crTyhfHz
	SO4ixI1TXqJfO7jPDNUVd1hyk5+t9AL6SlSuDSMW5owGuhlbq3lgOK4Rwxg=
X-Google-Smtp-Source: AGHT+IG+4JM6sOHf6rserWaHjsjZdxMbv+z9UAGB8/YaEYnJXYXYehVMNsEBMqf09adiz9s2MjyQ8Q==
X-Received: by 2002:a17:907:7289:b0:ac2:fd70:dda4 with SMTP id a640c23a62f3a-ac3f21116damr904660766b.19.1742718110611;
        Sun, 23 Mar 2025 01:21:50 -0700 (PDT)
Received: from alex-Mint.fritz.box ([2001:9e8:b3:8000:1ed2:493:be1e:d989])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ac3ef869f0esm471802266b.22.2025.03.23.01.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 01:21:50 -0700 (PDT)
From: Alexander Grund <theflamefire89@gmail.com>
To: cip-dev@lists.cip-project.org
Cc: uli+cip@fpond.eu
Subject: [PATCH 4.4 1/1] can: dev: make can_change_state() robust to be called with cf == NULL
Date: Sun, 23 Mar 2025 09:21:18 +0100
Message-Id: <20250323082118.8153-2-theflamefire89@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250323082118.8153-1-theflamefire89@gmail.com>
References: <20250323082118.8153-1-theflamefire89@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 23 Mar 2025 08:21:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18335

From: Marc Kleine-Budde <mkl@pengutronix.de>

In OOM situations where no skb can be allocated, can_change_state() may
be called with cf == NULL. As this function updates the state and error
statistics it's not an option to skip the call to can_change_state() in
OOM situations.

This patch makes can_change_state() robust, so that it can be called
with cf == NULL.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 2835aeb11c9f..eeeba3f5c8b4 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -341,6 +341,9 @@ void can_change_state(struct net_device *dev, struct can_frame *cf,
 	can_update_state_error_stats(dev, new_state);
 	priv->state = new_state;
 
+	if (!cf)
+		return;
+
 	if (unlikely(new_state == CAN_STATE_BUS_OFF)) {
 		cf->can_id |= CAN_ERR_BUSOFF;
 		return;
-- 
2.40.1


