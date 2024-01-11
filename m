Return-Path: <theflamefire89@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67821C47DA7
	for <webhook@archiver.kernel.org>; Thu, 11 Jan 2024 19:08:16 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.1122.1705000091981706567
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jan 2024 11:08:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LCMaa+ug;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: theflamefire89@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e63bc90f2so544425e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 11 Jan 2024 11:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705000090; x=1705604890; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vx0y2GgJm+XAKKEP7rJjn7HJUmbZ6sWmYvGUxi+/gKo=;
        b=LCMaa+ugmqIjxOBsHavs2WgS7wTIqqxBuSRhZp6hYqy9PWf5Con7OUzEQk/waMLsuB
         Alz85c3evLIpQj0eloJzXuDNOnHUJAfcOLZb1rZeY8vagtmpsQCi/rQuoX3gDfJHUWOR
         lx5nkOorjfVMplp9qrBxf+AOmxhXY7s1dzxP8U5n3ZygCdHxsDVPzeXOmwmdl/MTrHj3
         Gt0WvK+h8y52BmCMmTiBx2BQ4o/pezH3NrVMBSxBY0lWR12phF4Qg682hp0ZZNWSlk7G
         7/qyBRpGBpZdtArTFqIdQhler/9Wrxosh4XCukAdcz3kcEC9T04hdReF7nZrqzSaNY2+
         B6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705000090; x=1705604890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vx0y2GgJm+XAKKEP7rJjn7HJUmbZ6sWmYvGUxi+/gKo=;
        b=M/60UVy6fOn0xfihhmNKJohLKqWp45iOkf00iLkH0e6xeQdVXBDlRyAoQ8Dt/XwvWf
         hU9eL9jn3QsJoIdjmcUdFxDFlNjJWIXuwvtUAtgoNQ88b+5u6ZmdhOCXbxPvuhuuD5rE
         Bn7EYyekva5L+YDEmXjOkdlx8oH+vdwQYE5LP0jGgWBynsDQGFe2citEF+vsXH7UQSsr
         LQRV7QVR7/uDAkWGU26NzOhe/YkM4qfO2iZoxOk+Ss7iwcZLefmcMXwcy0MssQX6HHpL
         kVjExX1YPqwDy8S7NNAKWcjTSyZxpmRwG99vP6cGBp77ftW3kprWKwmmgm7VZoSd8gk3
         uVow==
X-Gm-Message-State: AOJu0YxlSoq2Bt0VHROfUNK3ZuTWP3bgR6UEITmNoOp/pLUx08FDJmNQ
	tD+Gz346vj4P/fcj9raWlm1E5PpDzMo=
X-Google-Smtp-Source: AGHT+IFlMo0uz+9nsAKymALkHbBFSNCsXxuQnswS7ti87+S0fDwPNMsChpWpQPdKG5Sg7+H6Id8hag==
X-Received: by 2002:a05:600c:4f08:b0:40e:39dd:b319 with SMTP id l8-20020a05600c4f0800b0040e39ddb319mr151712wmq.123.1705000090474;
        Thu, 11 Jan 2024 11:08:10 -0800 (PST)
Received: from alex-Mint.fritz.box (p200300f6af47620043a7429456d42e7a.dip0.t-ipconnect.de. [2003:f6:af47:6200:43a7:4294:56d4:2e7a])
        by smtp.googlemail.com with ESMTPSA id p12-20020a05600c468c00b0040e56830a35sm2964641wmo.18.2024.01.11.11.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 11:08:09 -0800 (PST)
From: Alexander Grund <theflamefire89@gmail.com>
To: cip-dev@lists.cip-project.org
Cc: uli+cip@fpond.eu
Subject: [PATCH 4.4 4/4] Bluetooth: hci_sock: Correctly bounds check and pad HCI_MON_NEW_INDEX name
Date: Thu, 11 Jan 2024 20:06:58 +0100
Message-Id: <20240111190658.153488-5-theflamefire89@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240111190658.153488-1-theflamefire89@gmail.com>
References: <20240111190658.153488-1-theflamefire89@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jan 2024 19:08:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14337

From: Kees Cook <keescook@chromium.org>

The code pattern of memcpy(dst, src, strlen(src)) is almost always
wrong. In this case it is wrong because it leaves memory uninitialized
if it is less than sizeof(ni->name), and overflows ni->name when longer.

Normally strtomem_pad() could be used here, but since ni->name is a
trailing array in struct hci_mon_new_index, compilers that don't support
-fstrict-flex-arrays=3 can't tell how large this array is via
__builtin_object_size(). Instead, open-code the helper and use sizeof()
since it will work correctly.

Additionally mark ni->name as __nonstring since it appears to not be a
%NUL terminated C string.

Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: Edward AD <twuufnxlz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org
Fixes: 18f547f3fc07 ("Bluetooth: hci_sock: fix slab oob read in create_monitor_event")
Link: https://lore.kernel.org/lkml/202310110908.F2639D3276@keescook/
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[AG: Remove __nonstring attribute not present in 4.4]
Signed-off-by: Alexander Grund <theflamefire89@gmail.com>
---
 net/bluetooth/hci_sock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 48fcbbde9d3f0..dbbd69bf43191 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -333,7 +333,8 @@ static struct sk_buff *create_monitor_event(struct hci_dev *hdev, int event)
 		ni->type = hdev->dev_type;
 		ni->bus = hdev->bus;
 		bacpy(&ni->bdaddr, &hdev->bdaddr);
-		memcpy(ni->name, hdev->name, strlen(hdev->name));
+		memcpy_and_pad(ni->name, sizeof(ni->name), hdev->name,
+			       strnlen(hdev->name, sizeof(ni->name)), '\0');
 
 		opcode = cpu_to_le16(HCI_MON_NEW_INDEX);
 		break;
-- 
2.40.1


