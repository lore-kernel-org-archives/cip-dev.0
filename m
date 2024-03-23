Return-Path: <theflamefire89@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11DCCD11BF
	for <webhook@archiver.kernel.org>; Sat, 23 Mar 2024 12:43:18 +0000 (UTC)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
 by mx.groups.io with SMTP id smtpd.web11.7968.1711197793125958469
 for <cip-dev@lists.cip-project.org>;
 Sat, 23 Mar 2024 05:43:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=O0lSjGHJ;
 spf=pass (domain: gmail.com, ip: 209.85.167.47, mailfrom: theflamefire89@gmail.com)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-513d599dbabso3893062e87.1
        for <cip-dev@lists.cip-project.org>; Sat, 23 Mar 2024 05:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711197791; x=1711802591; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iGJjpO9OgQ3dLT1xXLz4h5YyjG6lsjVpg5N3xATAr48=;
        b=O0lSjGHJ8KNPDHThd61NYAwg4NhesUS97tRzNIURR3WpJoQ8pFNbX51/DtuCeJqDBV
         Ik3LcJDS0PCW2WrpAIBqrds1X++fBEDW8lxyjerSUzY47sEjJW8PD/5sTkbvFuWvri7w
         BotNQ3nUqmLAfZcDPOobBF5bAZuj7abAwSE5EBkMtFitp/75biIaaTYHtYYyy3iKr+4m
         h8ZtbAhnDeIORki3oZV3sicW3eKXEsQg7v+tpB4l7KnspqHwsyLlrgOK6IYTGJdIEvoj
         g6QLG9B5svPtnAmU/V6DdD5qd/yoNz4kFD+AM4zziSwbhk6GMuNSlwmgl0FgUTTE8wHt
         QVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711197791; x=1711802591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iGJjpO9OgQ3dLT1xXLz4h5YyjG6lsjVpg5N3xATAr48=;
        b=MhnBhUr/74YXpJNdd9i6jbP2hGtUpuJJe6STpCDaoQtYe1rVeqcqnInVse3larltrz
         m1JWk9Cl6rXSwGutd+G0g5G3zB7pBFbKL7tcFZrKxL6RgJX9zJiFZIoNO5P41F4AQcD5
         XNL8VSFWT6BNNXs28iBbRu7RH5u8D9TmKjvA0aSQsPInCvXZQ1Cy2XRCPNXt5I5m8obS
         8P3Az+gZdsDrgynHmOtFtVoCSrKpLbZXZegtUVLP7OfmLu22jy/JUihDZ+Htw1ev134H
         KmAWUY3wwnUaOfOPF6PyKfexDg6gk4kxUWbR2ib5XIsVB3zCBoC2I9r3KxnzJwi2lJt/
         RxDw==
X-Gm-Message-State: AOJu0YynqCtjxXc2g5bvUR3EmQwasphtTC6Lv5s/2xK51quQgp8a0DMO
	zlnVCEtCvWnJV5FfvzckmfNI77tO06IY0bMqaC+ASlbSCKWnY8iAZQO1vXPa
X-Google-Smtp-Source: AGHT+IEPrxSsM9FlQm7HFhsaTXmK9fx3qZQT7Jdw2acCjXtX5WEqYLldD6F/Mbo2QZbr1v8nQrq9dQ==
X-Received: by 2002:a05:6512:3288:b0:515:845f:6008 with SMTP id p8-20020a056512328800b00515845f6008mr1743153lfe.57.1711197790896;
        Sat, 23 Mar 2024 05:43:10 -0700 (PDT)
Received: from alex-Mint.fritz.box (p200300f6af464b00f39f2cb4b6a1e773.dip0.t-ipconnect.de. [2003:f6:af46:4b00:f39f:2cb4:b6a1:e773])
        by smtp.googlemail.com with ESMTPSA id d6-20020a1709064c4600b00a46778db9e3sm866875ejw.164.2024.03.23.05.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 05:43:10 -0700 (PDT)
From: Alexander Grund <theflamefire89@gmail.com>
To: cip-dev@lists.cip-project.org
Cc: uli+cip@fpond.eu
Subject: [PATCH 4.4] bonding: Break instead of returning in alb_send_learning_packets
Date: Sat, 23 Mar 2024 13:43:01 +0100
Message-Id: <20240323124301.250422-1-theflamefire89@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 23 Mar 2024 12:43:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15411

From: Alexander Grund <flamefire89@gmail.com>

The upstream commit used a function which upon returning an error value
would break out of the surrounding loop.
In 4.4.x the loop is inside the function alb_send_learning_packets
hence returning would be wrong as it will skip the rcu_read_unlock.
Moreover returning a value from a void function doesn't even compile.

Fixes d6b83f1e (bonding: return -ENOMEM instead of BUG in alb_upper_dev_walk)

Signed-off-by: Alexander Grund <flamefire89@gmail.com>
---
 drivers/net/bonding/bond_alb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index 5321de9d80f7e..25943d6b04e12 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -986,7 +986,7 @@ static void alb_send_learning_packets(struct slave *slave, u8 mac_addr[],
 		if (netif_is_macvlan(upper) && !strict_match) {
 			tags = bond_verify_device_path(bond->dev, upper, 0);
 			if (IS_ERR_OR_NULL(tags))
-				return -ENOMEM;
+				break;
 
 			alb_send_lp_vid(slave, upper->dev_addr,
 					tags[0].vlan_proto, tags[0].vlan_id);
-- 
2.40.1


