Return-Path: <theflamefire89@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D593C28B30
	for <webhook@archiver.kernel.org>; Sun, 23 Mar 2025 08:21:54 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
 by mx.groups.io with SMTP id smtpd.web10.12443.1742718110175728462
 for <cip-dev@lists.cip-project.org>;
 Sun, 23 Mar 2025 01:21:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kgClO0DA;
 spf=pass (domain: gmail.com, ip: 209.85.218.41, mailfrom: theflamefire89@gmail.com)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac2af2f15d1so446654166b.1
        for <cip-dev@lists.cip-project.org>; Sun, 23 Mar 2025 01:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742718108; x=1743322908; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D8tgdvSIwgPQkTk8e9Z2cwQyr7DFkq7BENf45nNYgWQ=;
        b=kgClO0DA00/ovAjNwJT5hlYAQWdXV+xmVDBVWqcK7j/rwBFIqty+fd8xMsAC1QXkAG
         GupzEy7svcZpTJXBZLMqtyyA1Fy4DC15ewUOfOAy6jK5zAn/k5pYw7B16iKQfpseRhhP
         cQ4RR/siZobrL2RrDHeeWYDnFYTYJXwaaagg2mbi8T+0IEpZLlA/X6VPsN4F42tvHblc
         zuWOPsJhbjVp2Pky37Suc7/T7pDasblVtonl3FqxiJA17/Di1YZ/KEJ+IMzDs4J1OL8W
         9SzcvEALi+JihXyLIzGfSDJSkNYceqjz3uuZja3syvLh7gODUyu97hxbTJ3umX6IxwGT
         VcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742718108; x=1743322908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D8tgdvSIwgPQkTk8e9Z2cwQyr7DFkq7BENf45nNYgWQ=;
        b=gGSy59aDZgKD21u2unTcA7EHvZvG1/rGB2jeYm1p3o+FHaJPfdbA0MT6TSnU+mkxiR
         BP41b0B5FCEyDZ1U4pS/70Dc3ukzZVRySkYotE1rCT/dknqK6JWh9ydKlOc0McVURgIh
         U+hYtk911QBQfxEV4Q8V//o4+kzUVsxl3cFrXKI/xk4aRD/uz+0dtpapN3wsxjhZJP1N
         qy4R5hyoQJG50JUUtXMAtYkElVudEJMkY98PL7wGJjhCo7K9sI7A9Pp8CZ1zGibiT+fu
         00wXn48mhSaltdzf92+/qyLcwuHG3oQdHcyrtprBzO2BA+GWO29acqN3giS1jKzKWRDP
         cSkw==
X-Gm-Message-State: AOJu0Ywjd54NUIOXNepa/ysCpDw/tD9hyiLEfynfPkcpa1BQNfEa2/vh
	yD9nQuuzmAqoKYjOqsmtBEBjAfmchXJ2NZnOfvWVIiC/reU6U+h01IO+uw==
X-Gm-Gg: ASbGncvExmAKGLKjBndykQn+EKJjBb3l+80TVki49cOSxLiJitPVFPeq59gbWndCAkq
	lHdp35S0Mn0Kz7gjOJO54c42gF1I2M2zEG39OGutvdVfTawYKkC90VC/5Qy3OUV/7T4vLMg+Snf
	tggiHkg9hKKdYwIajokxxeDz7ETz5GyuIa2dDJ9zhjeqYNXuXCwphT/0ShJQaMO35kVR0UaK7FP
	QDB475/Fzz63WorWrXX2SSuQBwiEQF48Soti6WrPZCyEu0gC4VCb+tvNPEYkTscnrWSgIh5/Axe
	aZ1aBEcJTCT8kyMW1aoLZYak4EAjDi0AhYH+5DaykfaeKuDKLHGBCYiu/EY=
X-Google-Smtp-Source: AGHT+IF1MFpBJQ24yLqsNzSQu+4UMFx0QT04p/QveqmdcYBz3j9ZHUUE7xrfAzDK46cm2eDnZzYOmQ==
X-Received: by 2002:a17:907:7286:b0:ac2:e2bf:d437 with SMTP id a640c23a62f3a-ac3f255a25dmr894471666b.52.1742718108166;
        Sun, 23 Mar 2025 01:21:48 -0700 (PDT)
Received: from alex-Mint.fritz.box ([2001:9e8:b3:8000:1ed2:493:be1e:d989])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ac3ef869f0esm471802266b.22.2025.03.23.01.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 01:21:47 -0700 (PDT)
From: Alexander Grund <theflamefire89@gmail.com>
To: cip-dev@lists.cip-project.org
Cc: uli+cip@fpond.eu
Subject: [PATCH 4.4 0/1] Fix null pointer deref
Date: Sun, 23 Mar 2025 09:21:17 +0100
Message-Id: <20250323082118.8153-1-theflamefire89@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 23 Mar 2025 08:21:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18334

From: Alexander Grund <flamefire89@gmail.com>

The patch
"can: sun4i_can: sun4i_can_err(): call can_change_state() even if cf is NULL"
assumes the following patch which isn't applied yet to cip-4.4

Marc Kleine-Budde (1):
  can: dev: make can_change_state() robust to be called with cf == NULL

 drivers/net/can/dev.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.40.1


