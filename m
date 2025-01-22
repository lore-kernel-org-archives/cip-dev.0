Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6893FC02181
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 11:52:50 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.41907.1737546760152749210
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 03:52:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=ZRigHlaq;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-438a3216fc2so40030775e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 03:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737546758; x=1738151558; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/UPBktFKKZ2+4zFiQ8d88MTvMS3K0iI9Rt+Ln4Clbk=;
        b=ZRigHlaqnU9AfL8W4YbDp3lm9YhGZMGOdG5C5GhnxrMECej40yvO+iehMKwh038jGK
         8ncI4GqkSKeZqBh7vepdOOsU0AURyaWGMjnUpntAKEJ+LmhT0Jg18eS2Yb+ugfdN0jfs
         K6AGlhqNqmU9oSOAJLxfVs9iq9sO3ZWme20nLUT797H9lHdaWus9YMH0UQJONDDpVlrB
         aw+bEFM4ltQSw88oWwW/kJO042JC/kNc9nxtdvElIyjQR0NgalayZ7lIBHNxYSeTU7Ec
         ngApbCDkYs5kXvOk7+BpqtPlyAGcBS8Dv9jNaAekAwFrp5FJJlVsI9IfoZXbMDHE/bx9
         K8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737546758; x=1738151558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/UPBktFKKZ2+4zFiQ8d88MTvMS3K0iI9Rt+Ln4Clbk=;
        b=k5On3tlXS/5IHAl91OLNz+nziOSrNghWR0nEYP3SXFOWYHjBk2EJKzflwdg9Szuo4/
         WfWeBAjZVXD1n0A1kOyFPGhs8Mo/LKrQJHvF+3BGpTjRhbvcluQlguuPewVYETty2O9Z
         QhVmlfaN0AQhJcpTf1sgbWYmCRh+uYBYbeTE2DKKSm+V4fXMhIc/0bA5xiE4jxrN0ByC
         2sNeVtrVGODX9xh20wu7aM+DP6Wh11t2AbkTIA+O9OVnSJYRSBPZlLmpFWHK0JP3pPE8
         hAwSU0j5zA8T3itMZN71FGb7nYjG5hoYQ/6qsrmlb+Tw4QhNc1F4vvRexcfp9JqtOONe
         NN9w==
X-Forwarded-Encrypted: i=1; AJvYcCVC9Ww/x5MtJjBb3vTBWtwz2OaownWmPMfC8gKsG88/NIeB5uphWbO8SsR54riv3PQ1su2UUTsu@lists.cip-project.org
X-Gm-Message-State: AOJu0YxbOHz5zKWYsb1C5ymCl0V+DR8p7LGJCQIJ53EkXzpm5SnvVP1f
	h1VTkYsUc4tmWNqblkes6eTgX61htDZgftJ7Dl03437CHSYIeiIbE/lCxDx9hhM=
X-Gm-Gg: ASbGncuVIV4yMwqMsqP5CQutHyxaLa3405M140gUfFpp5aSSpl1i/BHUOS5B9IZrhIW
	b8Eq7XWQL7jJ/kwfbuUzpwb6K13xAZXTygv2HzZ2PvXBpEdC85rqTUtVzrIxxayxmKyEAuCQO6c
	19wNZO4qpb8k/0HqJnZW4TLVd6jnE2vemM8mvcCDytJ05oPOtbM4ei19kRRqFnrk06mcA3ACzC7
	rgG5zIom1QiU/THC9vas3pJFtt0hq/iMh17sZMGHiskciURbdUkMJ3ijnhirIkT5IKeyLCl0bcU
	RPsFI5irqKMOfoKTRjG77oM=
X-Google-Smtp-Source: AGHT+IErrMYwsfYLcxjLYF/R+btUrsP6XZOP61Cv7aX6l/9gJAKPaHSzj/o4ggY+WK7Y0Qi53O8uXw==
X-Received: by 2002:a05:600c:1f8c:b0:436:fb02:e90 with SMTP id 5b1f17b1804b1-438913cdaa8mr230411635e9.10.1737546758581;
        Wed, 22 Jan 2025 03:52:38 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b318990esm22887415e9.7.2025.01.22.03.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:52:38 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 05/16] clk: mux: Introduce devm_clk_hw_register_mux_parent_hws()
Date: Wed, 22 Jan 2025 13:52:19 +0200
Message-ID: <20250122115230.2885344-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122115230.2885344-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250122115230.2885344-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 11:52:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17583

From: Marijn Suijten <marijn.suijten@somainline.org>

commit df63af17f3375239e0be124844f304b4a4b60665 upstream.

Add the devres variant of clk_hw_register_mux_hws() for registering a
mux clock with clk_hw parent pointers instead of parent names.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20220629225331.357308-3-marijn.suijten@somainline.org
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 include/linux/clk-provider.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 9f34b4268e6a..50eaf1946009 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -988,6 +988,13 @@ struct clk *clk_register_mux_table(struct device *dev, const char *name,
 			      (parent_names), NULL, NULL, (flags), (reg),     \
 			      (shift), BIT((width)) - 1, (clk_mux_flags),     \
 			      NULL, (lock))
+#define devm_clk_hw_register_mux_parent_hws(dev, name, parent_hws,	      \
+					    num_parents, flags, reg, shift,   \
+					    width, clk_mux_flags, lock)       \
+	__devm_clk_hw_register_mux((dev), NULL, (name), (num_parents), NULL,  \
+				   (parent_hws), NULL, (flags), (reg),        \
+				   (shift), BIT((width)) - 1,		      \
+				   (clk_mux_flags), NULL, (lock))
 
 int clk_mux_val_to_index(struct clk_hw *hw, u32 *table, unsigned int flags,
 			 unsigned int val);
-- 
2.43.0


