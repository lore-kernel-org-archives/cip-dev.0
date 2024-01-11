Return-Path: <theflamefire89@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5561FC4707B
	for <webhook@archiver.kernel.org>; Thu, 11 Jan 2024 19:08:16 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.1133.1705000087061458420
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jan 2024 11:08:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PzJoRzsP;
 spf=pass (domain: gmail.com, ip: 209.85.128.41, mailfrom: theflamefire89@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e636fd3d2so790165e9.1
        for <cip-dev@lists.cip-project.org>; Thu, 11 Jan 2024 11:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705000085; x=1705604885; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GEGcuvf7D+I1ZB5Ymz5CQH7b54bWAxYAe2avmY1AeFU=;
        b=PzJoRzsPZ5fCKEG9kjlmQoJaxgxzIxYQGPELzEnVhMuFDZdd4T19k5I4KS5Qt++Oyl
         aHDekvzUWIH3T093T4hDmFKBy2OBU2CjdMM6lgg8erO3N/pGq5OXuEkTB/uNbTNPIjSr
         wYDXLaa7wQitqV6/gwsbY2DWti6gTYSUoSVdmWYAX94FQHPDTZmjhBBb1O6YpNVEcjEN
         LtyNTGoKYLkQlMXCd+jHpKojERMzsIkrE07c4C0Rl8aNVsF7/4lX8oZsjomXp9NhhDy2
         nVEhkEFnQau31SskHTFMeObbV3ce2lOljyv/gf8W3pyI4f2JdtLbq+vWfnBELN+12Prm
         eL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705000085; x=1705604885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GEGcuvf7D+I1ZB5Ymz5CQH7b54bWAxYAe2avmY1AeFU=;
        b=WMPDnnORyKTnzoyqR25nlN3PaFhu9bDera2ida+aTh35ek2cDFeu+qHkdKoQaDmPjZ
         M8jf++8rAJ9ctEIZRuXZrkL+kk56COaX2g29cahS5wh85E4b4J+43hLM25+iNCEk8nEU
         OxtwStGrwI+Rmj5me427f7dEqDdtcDGF4MrgwFStk8IpXmDEsZEGkXuyH3/pATlPltS8
         fIDUmaMaFqPFYR+Zk/H99hyJtD5Lxcnh6dX5vfA/BUgt7ovKTRGBJc0sBOKv8n45XgLC
         etRpobc3ozweuyDXAdr9J6UgNFYllqi/Plzl/EheLO7KTfvAj5KPZc9K3aU5D1vCWjSO
         WnIA==
X-Gm-Message-State: AOJu0YziE+IaUMoTQ+P4LWa7VeAbZrWXtyeqwTPQKoP+LiJsSEhitSAr
	2PSsb0cOWdIM7tAwJ4ZksPdKjwiF37o=
X-Google-Smtp-Source: AGHT+IFYR9AwnYEQngqsPF/+qyiHNLgev0NcVS8N9lu+vlMa4RjCP8luGeIqeTR9takHyt7IsXshIg==
X-Received: by 2002:a05:600c:c19:b0:40d:94f5:b8f5 with SMTP id fm25-20020a05600c0c1900b0040d94f5b8f5mr154958wmb.139.1705000085241;
        Thu, 11 Jan 2024 11:08:05 -0800 (PST)
Received: from alex-Mint.fritz.box (p200300f6af47620043a7429456d42e7a.dip0.t-ipconnect.de. [2003:f6:af47:6200:43a7:4294:56d4:2e7a])
        by smtp.googlemail.com with ESMTPSA id p12-20020a05600c468c00b0040e56830a35sm2964641wmo.18.2024.01.11.11.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 11:08:03 -0800 (PST)
From: Alexander Grund <theflamefire89@gmail.com>
To: cip-dev@lists.cip-project.org
Cc: uli+cip@fpond.eu
Subject: [PATCH 4.4 0/4] Bluetooth: hci_sock: Fix possible OOB write in create_monitor_event
Date: Thu, 11 Jan 2024 20:06:54 +0100
Message-Id: <20240111190658.153488-1-theflamefire89@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jan 2024 19:08:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14333

From: Alexander Grund <flamefire89@gmail.com>

This basically fixes the `memcpy(dst, src, strlen(src))`
where dst is a fixed size array and hence the copy can overflow it.

The changes to string[.h] introduce the required function.
The first commit (initially introducing it) uses some fortification
checks & macros not available in 4.4 which I kept in as the get
removed in the very next commit.
I also included the fixup commit moving it out of the header although
I'm not sure this is strictly required in 4.4. But it doesn't hurt either.

Guenter Roeck (1):
  string: uninline memcpy_and_pad

Kees Cook (1):
  Bluetooth: hci_sock: Correctly bounds check and pad HCI_MON_NEW_INDEX
    name

Martin Wilck (2):
  string.h: add memcpy_and_pad()
  string.h: un-fortify memcpy_and_pad

 include/linux/string.h   |  3 +++
 lib/string_helpers.c     | 20 ++++++++++++++++++++
 net/bluetooth/hci_sock.c |  3 ++-
 3 files changed, 25 insertions(+), 1 deletion(-)

-- 
2.40.1


