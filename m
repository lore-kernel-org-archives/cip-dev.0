Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BEBC71157
	for <webhook@archiver.kernel.org>; Wed, 18 Jun 2025 09:13:55 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web11.38103.1750218585579107245
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Jun 2025 20:49:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GHjyO3BZ;
 spf=pass (domain: gmail.com, ip: 209.85.216.51, mailfrom: zaq14760@gmail.com)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-313910f392dso5724384a91.2
        for <cip-dev@lists.cip-project.org>; Tue, 17 Jun 2025 20:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750218584; x=1750823384; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaL0HiH9jBIX2TlypOzxXsG0yj+HeZtCgZDd/6Q8FqQ=;
        b=GHjyO3BZBCakz7XKuhIKT9NzoAn1CNLf3cW1TXX4fzrxcDDjk0wuhdKtS2SmFIVkBn
         5pt5k1bIhwPMkZDn0fzYyHXXKFiNROahCD9krZ/XlzIOTEGKj+dWkbI9WaTEag5NDXnm
         gQ0ucKSgi92yghY1Ki9IwhRGPqJxMcBUga86IhI7y8KGbwXu7Mt3iNZrm23CkF3lZOna
         pJKOX75dEQYo2T6AqdzzPocwySoLnjZ44XoEB09fZFgvx5EQd+DfZALbPczoB7MU+JX5
         IxDCn1IxahDJWqoesfvoWMUhocHP7j6upytWIqxwKuNDUSz28fHXQwo7jPEG7xd+BVC1
         eWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750218584; x=1750823384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EaL0HiH9jBIX2TlypOzxXsG0yj+HeZtCgZDd/6Q8FqQ=;
        b=Tbu0YBXTOWkOjM03ivEYWnfy0zRM1FjXukmuTGGUj4EjBhzP/W6l5EdzVV8RzhJoZ5
         R1Flz1SQwonUs1GF1B5dlr9QfY4/MrrNYOA1btaGFf/E0QHjzWu3mek9XGbWAK6ibAyf
         C2jHt70xk2m0QqKcB3IMo+88a5WiqAo5cKpKcn+sIDnxJMfnk+z267EM6ykt7YYX3WMx
         FmJ1kfWCAWzV4dZ9oHSilqHft872bNwLteiXDm/roz6EIjoaAtkeyP44Vi/jVQsrkwK8
         e8tKUwKQuwmtO6IMhUqvql/LIb8euBEUoCgG70ZohGYrpRuYvF/KFM4bhx7tUlFpXg0A
         i2vQ==
X-Gm-Message-State: AOJu0YxiidL3e08OFRdI70gmtZi4TqXOOsYn7bhODmb+kERIIl1JHq55
	Q1lUP88ttIfwpsn6MQo1MIvx2SFygb0fyJm6+5enPHgvTiSI4/Vmd3FciSlibrMu
X-Gm-Gg: ASbGncsSTwHhozAmqRy0zkY0TfB2Qnw9ob0tpW1l3jWSxbv+NWcKOwEr31qLCRGXabj
	K1b1pxXzK/wFLOKroav98LeuF8bsgDk3mYBDeztEFJmcf4GE9hKnSAM7+i6JMhi2Gdngl6EVpSq
	hmYKugV7Lxy04ORpy5eTl9d3iizqF1AZDJteWIKt0EuBU8ZRV4OZ/gaPDbTV4ysUoERuSshOST9
	7mXhC3TXgyWuFIx3HzRMzugxy8hzRFxGqFr+c2D6Fpo8dYMDd3I6El6i8fmgflVKJzSD7yQTpGT
	Zc3tKKnlNHEPehwiGW54O2HOcMgb9Iwvep2bi3BmBKGIlMmS6YfAL0NRmh/vDLt++jSCjwrU95D
	TvV4mHNfrhTArcqqHCeEj+hecKLnWm9FYXyij/yyjCIMOMJsGkw==
X-Google-Smtp-Source: AGHT+IFlQPDvI/3JANHxQyMjprPqRqAF4Al+BfZbtntNBjRSmhzEFwF35vIG19QDRI3yejxRp2Fheg==
X-Received: by 2002:a17:90b:3c02:b0:311:df4b:4b82 with SMTP id 98e67ed59e1d1-313f1c6f670mr21677358a91.4.1750218584333;
        Tue, 17 Jun 2025 20:49:44 -0700 (PDT)
Received: from lcwang-Precision-3630-Tower.. (211-23-39-77.hinet-ip.hinet.net. [211.23.39.77])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236736cb4f9sm63418405ad.138.2025.06.17.20.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 20:49:43 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
To: cip-dev@lists.cip-project.org
Cc: drm@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	noralf@tronnes.org,
	robh+dt@kernel.org,
	krzk@kernel.org,
	zaq14760@gmail.com,
	onlywig@gmail.com
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Mayqueen name
Date: Wed, 18 Jun 2025 11:49:34 +0800
Message-Id: <20250618034936.172150-2-zaq14760@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250618034936.172150-1-zaq14760@gmail.com>
References: <20250618034936.172150-1-zaq14760@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jun 2025 09:13:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19128

From: Wig Cheng <onlywig@gmail.com>

Mayqueen is a Taiwan-based company primarily focused on the development
of arm64 development boards and e-paper displays.

Signed-off-by: Wig Cheng <onlywig@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 2735be1a8..8434ae355 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -631,6 +631,8 @@ patternProperties:
     description: MaxBotix Inc.
   "^maxim,.*":
     description: Maxim Integrated Products
+  "^mayqueen,.*":
+    description: Mayqueen Technologies Ltd.
   "^mbvl,.*":
     description: Mobiveil Inc.
   "^mcube,.*":
-- 
2.34.1


