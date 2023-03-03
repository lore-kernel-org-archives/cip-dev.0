Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D237FC678D4
	for <webhook@archiver.kernel.org>; Fri,  3 Mar 2023 14:43:56 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
 by mx.groups.io with SMTP id smtpd.web11.23984.1677852539367524897
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Mar 2023 06:08:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=kmDROQD0;
 spf=pass (domain: gmail.com, ip: 209.85.208.41, mailfrom: error27@gmail.com)
Received: by mail-ed1-f41.google.com with SMTP id f13so10807266edz.6
        for <cip-dev@lists.cip-project.org>; Fri, 03 Mar 2023 06:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677852537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dO1LQEOQA2lkLxNnzJdei9SHPRSSQuSAKfOh0LDyQes=;
        b=kmDROQD0vnTJOY0p5PTVNkvl4pe9krLiq+v0urpwG73Mg1gDHM8az1DTj9iWZVbggh
         RK+rSYQV4GoeVJU6bmeMXtUDJQB2GWvtBKnUuI3vPA6stYScj4fZ8aDyfgUXreDr+nbG
         wBEGSuj4hEuW+rrAzcPMh4CSs3ILIZDo9mZU9SNbWaSLIeSp0Vq92dkmZYHadS+jIVCO
         2tONXD+JucztRaCseYCdSAr46ebRQk0XVJMH94Pg5L6J4AZvMYI7QukhCmKMlO5tZ7ih
         NL6AR7wmGTcP76SaFDY+XllaXU+ioFj6edrSKNLxgIv4diAu37Z9vnsIJ5Nib9Bn2Tts
         WOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677852537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dO1LQEOQA2lkLxNnzJdei9SHPRSSQuSAKfOh0LDyQes=;
        b=FMP1IlLmj9LS1pvVVMmXL8UtTWAcVtLA7y6PQABrebPtqeZeiH9hgANvHPq0+z1ZLF
         Ffk1cyrM/EnIA0M614LymSzg2LiVWccsCN8CF5+ULZ5SIMzZhqCWfKkqUplL8XBtTaet
         rcGsh4I37Y932MQTDtnJtvb1Xp9uqTrVI6GRx1OR1vm5gbqGf8Xb/HlQrY2epv8IKdTl
         X91CTCBUqvE/rgbFYVTBhhbmqRUfi0su7crbaA9sPFgwvQEKZS7xuDm6NS5ecxyzp96/
         Ulek8RG7Q54ivBCpxNozoJikipzFiFEPYnQ8dkTSzAKKmfuq9EF4tOh8O2l3518FR9Sg
         x2Tg==
X-Gm-Message-State: AO0yUKUD0EZ7F8uPLyDPc1q+SLqCn5OBcug8rC1P5fi1fbN+9FfJjTWd
	yBhKt2gkgLKZT3UTzifniLQ=
X-Google-Smtp-Source: AK7set9/au6JhZLhgOfu8Txo6X0/5vbLriYxUgz76BGPoQ3uFaVTHaDJEq+4Hlx22FhPKSV3NHxYmg==
X-Received: by 2002:aa7:c0c8:0:b0:4a2:5652:d8ba with SMTP id j8-20020aa7c0c8000000b004a25652d8bamr1768218edp.18.1677852537515;
        Fri, 03 Mar 2023 06:08:57 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v12-20020a50c40c000000b004bb810e0b87sm1212343edf.39.2023.03.03.06.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 06:08:56 -0800 (PST)
Date: Fri, 3 Mar 2023 17:08:51 +0300
From: Dan Carpenter <error27@gmail.com>
To: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Cc: cip-dev <cip-dev@lists.cip-project.org>
Subject: Re: New CVE entries this week
Message-ID: <8d6b7cdd-11b0-468d-aa8e-abe02029301a@kili.mountain>
References: <CAODzB9qjdhQkZ+tALHpDLHoK7GAf8Uybfzp8mxXt=Dwnn_0RjA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAODzB9qjdhQkZ+tALHpDLHoK7GAf8Uybfzp8mxXt=Dwnn_0RjA@mail.gmail.com>
Content-Type: multipart/mixed; boundary="rulzNrqv9Z8FNHCQ"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Mar 2023 14:43:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10913

--rulzNrqv9Z8FNHCQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 19, 2023 at 09:14:53AM +0900, Masami Ichikawa wrote:
> CVE-2023-23559: rndis_wlan: Prevent buffer overflow in rndis_query_oid
> 
> CVSS v3 score is not provided
> 
> In rndis_query_oid in drivers/net/wireless/rndis_wlan.c in the Linux
> kernel through 6.1.5, there is an integer overflow in an addition.
> 
> This bug was introduced by 80f8c5b434f9 ("rndis_wlan: copy only useful
> data from rndis_command respond") in 2.6.35-rc1.
> 
> Fixed status
> Patch is in the patchwork but not merged into the mainline yet.

I have a Smatch check for this kind of bug.  It's crap code that I never
pushed.  There are two reasons why it didn't warn for this bug:

1) For some reason it was only looking at bounds checks to a known limit
   instead of to a variable limit.
2) It only generated a warning when an underflowed variable was assigned
   to something or passed to a function.  Here the underflowed variable
   was used for math.

Both these issues are easily addressed.  Here are the slightly cleaned
up warnings.  It's mostly false positives (obviously I have been looking
at the results for the past ten years and fixing the underflow bugs
which were not false positives).  The warnings in drivers/md/md.c and
fs/ksmbd/vfs.c are new and thus not false positives.  I will send bug
reports for these.

The bug list would probably have been longer but I've been re-writing
the taint handling code for marking variables as user controlled.

The line numbers are from yesterday's linux-next.

regards,
dan carpenter

--rulzNrqv9Z8FNHCQ
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="check_no_lowerbound_test.c"

/*
 * Copyright (C) 2013 Oracle.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see http://www.gnu.org/copyleft/gpl.txt
 */

/*
 * This is another integer underflow test.  I look at stituations where:
 * 1) We have user data.
 * 2) We cap the upper bound but not the lower bound.
 * 3) We assign the data to something else either through an assignment or by
 *    passing it as a parameter.
 */

#include "smatch.h"
#include "smatch_extra.h"

static int my_id;

STATE(upper_capped);

static void match_condition(struct expression *expr)
{
	struct range_list *rl;
	sval_t sval;

	if (expr->type != EXPR_COMPARE)
		return;
	if (expr->op != '>' && expr->op != SPECIAL_GTE)
		return;
	if (get_implied_value(expr->right, &sval) &&
	    sval.value == 0)
		return;
	get_absolute_rl(expr->left, &rl);
//	if (!get_user_rl(expr->left, &rl))
//		return;
	if (!sval_is_negative(rl_min(rl)))
		return;
	set_true_false_states_expr(my_id, expr->left, NULL, &upper_capped);
}

static void XXX_check_for_lower_bound(struct expression *expr)
{
	struct range_list *rl;
	char *name;

	if (get_state_expr(my_id, expr) != &upper_capped)
		return;
	if (!get_user_rl(expr, &rl))
		return;
	if (sval_is_negative(rl_max(rl)))
		return;
	if (!sval_is_min(rl_min(rl)) ||
	    !sval_is_negative(rl_min(rl)))
		return;

	name = expr_to_str(expr);
	sm_msg("warn: no lower bound on '%s'", name);
	free_string(name);
}

static void check_for_lower_bound(struct expression *expr)
{
	struct smatch_state *state;
	sval_t sval;
	char *name;

	// This skips a lot of unnecessary stuff
	if (expr->type == EXPR_CALL)
		return;

	XXX_check_for_lower_bound(expr);
}

static void match_assign(struct expression *expr)
{
	check_for_lower_bound(expr->right);
}

static void match_call(struct expression *expr)
{
	struct expression *arg;

	FOR_EACH_PTR(expr->args, arg) {
		check_for_lower_bound(arg);
	} END_FOR_EACH_PTR(arg);
}

static void match_binop(struct expression *expr)
{
	check_for_lower_bound(expr->left);
	check_for_lower_bound(expr->right);
}

void check_no_lowerbound_test(int id)
{
	my_id = id;

	add_hook(&match_condition, CONDITION_HOOK);
	add_hook(&match_assign, ASSIGNMENT_HOOK);
	add_hook(&match_call, FUNCTION_CALL_HOOK);
	add_hook(&match_binop, BINOP_HOOK);
}

--rulzNrqv9Z8FNHCQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=err-list

drivers/staging/gdm724x/netlink_k.c:103 netlink_send() warn: no lower bound on 'group'
drivers/acpi/nfit/core.c:484 acpi_nfit_ctl() warn: no lower bound on 'family'
drivers/md/md.c:3170 slot_store() warn: no lower bound on 'slot'
drivers/scsi/myrs.c:1508 disable_enclosure_messages_store() warn: no lower bound on 'value'
drivers/video/fbdev/matrox/matroxfb_g450.c:184 g450_set_ctrl() warn: no lower bound on 'p->value'
drivers/net/wireless/ath/carl9170/debug.c:570 carl9170_debugfs_hw_ioread32_write() warn: no lower bound on 'n'
drivers/net/ethernet/smsc/smc91x.c:1726 smc_ethtool_seteeprom() warn: no lower bound on 'offset'
security/smack/smackfs.c:903 smk_set_cipso() warn: no lower bound on 'catlen'
fs/ksmbd/vfs.c:1040 ksmbd_vfs_fqar_lseek() warn: no lower bound on 'length'
fs/ksmbd/vfs.c:1041 ksmbd_vfs_fqar_lseek() warn: no lower bound on 'start'
fs/ksmbd/smb2pdu.c:7759 smb2_ioctl() warn: no lower bound on 'off'
net/core/skbuff.c:2694 skb_copy_bits() warn: no lower bound on 'offset'


--rulzNrqv9Z8FNHCQ--

