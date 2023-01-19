Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FEBC00A5A
	for <webhook@archiver.kernel.org>; Thu, 19 Jan 2023 12:49:11 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web11.40633.1674114685325166958
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Jan 2023 23:51:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=oQLUvWZn;
 spf=pass (domain: gmail.com, ip: 209.85.221.54, mailfrom: error27@gmail.com)
Received: by mail-wr1-f54.google.com with SMTP id d2so961657wrp.8
        for <cip-dev@lists.cip-project.org>; Wed, 18 Jan 2023 23:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tQN5QWxxX4yeXQdGtOq7iT1lOF9ivUP2qDGMRmUaJF0=;
        b=oQLUvWZnZryqSEUmf5lFcQYniEz+ph0XnhKvjjH2xu/cplNNTyFZTxoE2jSPJ/8AeQ
         +k+wL1BpRK2EzMWc2LPPhzt29iXGkoJry/Gy+BymtYL2SrkX5anvrmhnbpmeQ6v4h8KX
         5ev5k1W5xuBXkEL/LOZRjtW80yKEobsY0boJT70KvGN+3QYh6bY6BljORRmzAj6ih3ca
         +11zaFm77sqAGAVMvCaIS/79heXTBDROzRtsSv0ov3r/Itf6lm3TQ5JbDtpNGY/pObVg
         D7A6c8sq4qfTeWMYzlVp2TXewRmG4h9GvOXwxWS3yqeayDLRn4PghQttbQZDy7aN8c3R
         4d3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQN5QWxxX4yeXQdGtOq7iT1lOF9ivUP2qDGMRmUaJF0=;
        b=N5mXJlH1ITHmd1lWQKdk8M3AH/BWK5bkg/fApzm03QPnrGZ9CUgOnQUQfDoo9VHJY8
         XPamSZ1weTlCrwhjLI0Jr6xPi1L9jJWWb74dXL65P3+mJbIzPDq/yF6uj6Hczjt81Xoq
         sVE2/MEzkm5XIpFXkAZjAt9R6BwcQIThHzcrrnMEeJkOupuAPg+AMHEGc0nYatzfmPR9
         KPUKTemYhBXkMo1QZ1LtGE7rT+KxTAnKTFcoRzjjAs8QJufdxnv5wbpEQCuU54Psju4a
         gJL3lPK9p8Am4Ee7bCr98wj3+zrDQ7xy+V3CsxwdnvWnmGexolyznh4jGQc2nV90MRKC
         sEnA==
X-Gm-Message-State: AFqh2kqTQx5KpOeniCMjNfFlZwHiiGoJE8o69LymKe6dJ3HyHIqWhmLU
	GC4lnRz0b2ewGgS4aYFXvMM=
X-Google-Smtp-Source: AMrXdXvkSI9/0Da6tjp124zwfK7gr3dT0OMaP7l2BvhrwiWfd+c+1yA02yAk7SVVxQcE2fhzQr3TPw==
X-Received: by 2002:adf:fa88:0:b0:2bd:feb5:fb7b with SMTP id h8-20020adffa88000000b002bdfeb5fb7bmr7866955wrr.33.1674114683598;
        Wed, 18 Jan 2023 23:51:23 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j15-20020adfd20f000000b002be2a4b521fsm5155414wrh.45.2023.01.18.23.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 23:51:22 -0800 (PST)
Date: Thu, 19 Jan 2023 10:51:18 +0300
From: Dan Carpenter <error27@gmail.com>
To: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Cc: cip-dev <cip-dev@lists.cip-project.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: New CVE entries this week
Message-ID: <Y8j2dnYDZnw+DcEw@kili>
References: <CAODzB9oy2nCYdfa7vzG59nQ6owAKUv+jkqD4tpufn+k8_kjuaw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAODzB9oy2nCYdfa7vzG59nQ6owAKUv+jkqD4tpufn+k8_kjuaw@mail.gmail.com>
Content-Type: multipart/mixed; boundary="3VO4Cpa8YkOiSFt1"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 12:49:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10438

--3VO4Cpa8YkOiSFt1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 15, 2022 at 12:25:18PM +0900, Masami Ichikawa wrote:
> CVE-2022-4378: Linux kernel stack-based buffer overflow in __do_proc_dointvec
> 
> CVSS v3 score is not provided
> 
> A stack overflow bug was found in __do_proc_dointvec() which missed
> checking on user input.
> This bug affected all stable kernels. It seems as if 4.4 is affected too.
> 
> Fixed status
> mainline: [bce9332220bd677d83b19d21502776ad555a0e73,
> e6cfaf34be9fcd1a8285a294e18986bfc41a409c]

One thing that we used to do at Oracle was a bi-weekly meeting where we
would go through these lists and try to be a bit proactive about
preventing future bugs.  For me I'm trying to use Smatch for static
analysis.

There are some bugs which Smatch can't identify like race conditions or
if there is an issue with the spec.  But for a lot of bugs can be
prevented.  So it's often an issue of 1) There isn't a Smatch check for
that.  2) The Smatch check exists but isn't working correctly.  3) The
Smatch check prints a warning but there are too many warning for that
check so I can't go through them all.

First of all, why wasn't *size marked as user controlled?  It turned out
that it comes from iov_iter_count() and that wasn't marked as user
controlled.  Fix that:
https://github.com/error27/smatch/commit/70ee7aa1ae8cc07767096e16fa2de68a62507a3e

Once that was fixed, it turned out that I did have an unpublished check
which printed a warning.
kernel/sysctl.c:358 proc_get_long() warn: check 'tmp[len]' for negative offsets 'len' = s32min.  extra = 's32min-21'

But it turns out that warning was because of a bug.  The check was
asking can "*size" be user controlled and what is the minimum possible
value negative, but it should have been asking if the minimum user
controled value is negative.

Fixing the check to as about user controlled values silenced the
warning.  The issue with that is:

	left -= proc_skip_spaces(&p);

Subtractions are very hard to handle correctly because you need to keep
track of the relationships between multiple variables.  Smatch
deliberately assumes that this subtraction cannot underflow.  Otherwise
you end up with too many false positives...

I've been sitting on this check for the past ten years without
publishing it.  May as well attach it now and also the results.  I don't
know why the check has __per_cpu_offset stuff or why it ignores ntohl().
I should probably delete that and see what happens.  Going through the
results, a bunch of false positives are cause by subtraction (which is
complicated).  Or because Smatch doesn't understand about
array_index_nospec() (I should fix that).

Anyway, even though I wasn't able to generate a warning for this bug,
it was still useful to have the discussion and improve Smatch.

regards,
dan carpenter


--3VO4Cpa8YkOiSFt1
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="check_underflow.c"

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

#include "smatch.h"
#include "smatch_slist.h"
#include "smatch_extra.h"

static int my_id;

int is_user_macro(struct expression *expr)
{
	char *macro;
	struct range_list *rl;

	macro = get_macro_name(expr->pos);

	if (!macro)
		return 0;
	if (get_implied_rl(expr, &rl) && !is_whole_rl(rl))
		return 0;
	if (strcmp(macro, "ntohl") == 0)
		return 1;
	if (strcmp(macro, "ntohs") == 0)
		return 1;
	return 0;
}

static void array_check(struct expression *expr)
{
	struct expression *offset;
	struct smatch_state *state;
	struct range_list *rl;
	sval_t min;
	char *name, *offset_name;

	expr = strip_expr(expr);
	if (!is_array(expr))
		return;
	if (is_user_macro(expr))
		return;

	offset = get_array_offset(expr);

	if (!get_user_rl(offset, &rl))
		return;
	if (!sval_is_negative(rl_min(rl)))
		return;

	state = get_state_expr(SMATCH_EXTRA, offset);
	if (state && !estate_rl(state))
		return;

	name = expr_to_str(expr);
	if (option_project == PROJ_KERNEL &&
	    name &&
	    strncmp("__per_cpu_offset", name, strlen("__per_cpu_offset")) == 0)
		goto free_name;
	offset_name = expr_to_str(offset);
	sm_msg("warn: check '%s' for negative offsets '%s' = %s.  extra = '%s'", name, offset_name, sval_to_str(min), state ? state->name : "unknown");
	free_string(offset_name);
free_name:
	free_string(name);
}

void check_underflow(int id)
{
	my_id = id;

	add_hook(&array_check, OP_HOOK);
}

--3VO4Cpa8YkOiSFt1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=err-list

drivers/accessibility/speakup/varhandlers.c:248 spk_set_num_var() warn: check 'var_data->u.n.out_str[val]' for negative offsets 'val' = 140405757965328.  extra = 's32min-s32max'
drivers/acpi/nfit/core.c:488 acpi_nfit_ctl() warn: check 'acpi_desc->family_dsm_mask[family]' for negative offsets 'family' = 139892171397136.  extra = 's32min-s32max'
drivers/gpu/drm/i915/gem/i915_gem_context.c:658 set_proto_ctx_engines_parallel_submit() warn: check 'ext->engines[n]' for negative offsets 'n' = 140477319050128.  extra = 's32min-s32max'
drivers/gpu/drm/i915/gem/i915_gem_context.c:663 set_proto_ctx_engines_parallel_submit() warn: check 'siblings[n]' for negative offsets 'n' = 140477317644816.  extra = 's32min-s32max'
drivers/gpu/drm/i915/gem/i915_gem_context.c:666 set_proto_ctx_engines_parallel_submit() warn: check 'siblings[n]' for negative offsets 'n' = 140477317652624.  extra = 's32min-s32max'
drivers/gpu/drm/i915/gem/i915_gem_context.c:678 set_proto_ctx_engines_parallel_submit() warn: check 'siblings[n]' for negative offsets 'n' = 140477316505488.  extra = 's32min-s32max'
drivers/gpu/drm/i915/gem/i915_gem_context.c:679 set_proto_ctx_engines_parallel_submit() warn: check 'siblings[n]' for negative offsets 'n' = 140477316429968.  extra = 's32min-s32max'
drivers/gpu/drm/i915/gem/i915_gem_context.c:697 set_proto_ctx_engines_parallel_submit() warn: check 'siblings[n]' for negative offsets 'n' = 140477314564112.  extra = 's32min-s32max'
drivers/net/ethernet/atheros/atl1e/atl1e_ethtool.c:283 atl1e_set_eeprom() warn: check 'eeprom_buff[last_dword - first_dword]' for negative offsets 'last_dword - first_dword' = 140418698139664.  extra = 'unknown'
drivers/net/ethernet/atheros/atl1e/atl1e_ethtool.c:283 atl1e_set_eeprom() warn: check 'eeprom_buff[last_dword - first_dword]' for negative offsets 'last_dword - first_dword' = 140418698146704.  extra = 'unknown'
drivers/net/ethernet/atheros/atlx/atl2.c:1958 atl2_set_eeprom() warn: check 'eeprom_buff[last_dword - first_dword]' for negative offsets 'last_dword - first_dword' = 139632960086160.  extra = 'unknown'
drivers/net/ethernet/atheros/atlx/atl2.c:1958 atl2_set_eeprom() warn: check 'eeprom_buff[last_dword - first_dword]' for negative offsets 'last_dword - first_dword' = 139632960093968.  extra = 'unknown'
drivers/net/ethernet/emulex/benet/be_ethtool.c:1311 be_set_rxfh() warn: check 'adapter->rx_obj[j]' for negative offsets 'j' = 140694977039248.  extra = 's32min-s32max'
drivers/net/ethernet/intel/e1000/e1000_ethtool.c:506 e1000_set_eeprom() warn: check 'eeprom_buff[last_word - first_word]' for negative offsets 'last_word - first_word' = 140658616621712.  extra = 'unknown'
drivers/net/ethernet/intel/e1000e/ethtool.c:610 e1000_set_eeprom() warn: check 'eeprom_buff[last_word - first_word]' for negative offsets 'last_word - first_word' = 140551373387920.  extra = 'unknown'
drivers/net/ethernet/intel/igb/igb_ethtool.c:824 igb_set_eeprom() warn: check 'eeprom_buff[last_word - first_word]' for negative offsets 'last_word - first_word' = 140138690652048.  extra = 'unknown'
drivers/net/ethernet/intel/igc/igc_ethtool.c:547 igc_ethtool_set_eeprom() warn: check 'eeprom_buff[last_word - first_word]' for negative offsets 'last_word - first_word' = 139829128802320.  extra = 'unknown'
drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:1077 ixgbe_set_eeprom() warn: check 'eeprom_buff[last_word - first_word]' for negative offsets 'last_word - first_word' = 140353874581776.  extra = 'unknown'
drivers/net/ethernet/intel/ixgb/ixgb_ethtool.c:437 ixgb_set_eeprom() warn: check 'eeprom_buff[last_word - first_word]' for negative offsets 'last_word - first_word' = 140135473156368.  extra = 'unknown'
drivers/net/usb/asix_common.c:709 asix_set_eeprom() warn: check 'eeprom_buff[last_word - first_word]' for negative offsets 'last_word - first_word' = 140650219544976.  extra = 'unknown'
drivers/net/usb/ax88179_178a.c:601 ax88179_set_eeprom() warn: check 'eeprom_buff[last_word - first_word]' for negative offsets 'last_word - first_word' = 140521901784592.  extra = 'unknown'
drivers/net/wireless/ath/wcn36xx/smd.c:1988 wcn36xx_smd_send_beacon() warn: check 'msg_body.beacon[tim_off + 5 + pvm_len + pad]' for negative offsets 'tim_off + 5 + pvm_len + pad' = 140733510315840.  extra = 'unknown'
drivers/net/wireless/ath/wcn36xx/smd.c:1988 wcn36xx_smd_send_beacon() warn: check 'msg_body.beacon[tim_off + 5 + pvm_len + pad]' for negative offsets 'tim_off + 5 + pvm_len + pad' = 140733510315840.  extra = 'unknown'
drivers/net/wireless/ath/wcn36xx/smd.c:1988 wcn36xx_smd_send_beacon() warn: check 'msg_body.beacon[tim_off + 5 + pvm_len + pad]' for negative offsets 'tim_off + 5 + pvm_len + pad' = 140733510315840.  extra = 'unknown'
drivers/pci/endpoint/functions/pci-epf-ntb.c:2022 epf_ntb_mw1_store() warn: check 'ntb->mws_size[win_no - 1]' for negative offsets 'win_no - 1' = 140731588284720.  extra = 'unknown'
drivers/pci/endpoint/functions/pci-epf-ntb.c:2024 epf_ntb_mw2_store() warn: check 'ntb->mws_size[win_no - 1]' for negative offsets 'win_no - 1' = 140731588284720.  extra = 'unknown'
drivers/pci/endpoint/functions/pci-epf-ntb.c:2026 epf_ntb_mw3_store() warn: check 'ntb->mws_size[win_no - 1]' for negative offsets 'win_no - 1' = 140731588284720.  extra = 'unknown'
drivers/pci/endpoint/functions/pci-epf-ntb.c:2028 epf_ntb_mw4_store() warn: check 'ntb->mws_size[win_no - 1]' for negative offsets 'win_no - 1' = 140731588284720.  extra = 'unknown'
drivers/staging/rtl8192e/rtllib_rx.c:2158 rtllib_parse_info_param() warn: check 'info_element->data[3 + offset]' for negative offsets '3 + offset' = 140007844424848.  extra = 'unknown'
drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c:1658 ieee80211_parse_info_param() warn: check 'info_element->data[3 + offset]' for negative offsets '3 + offset' = 140178157514768.  extra = 'unknown'
fs/btrfs/send.c:8260 btrfs_ioctl_send() warn: check 'sctx->clone_roots[sctx->clone_roots_cnt++]' for negative offsets 'sctx->clone_roots_cnt' = 140002303789072.  extra = 's32min-s32max'
fs/btrfs/send.c:8260 btrfs_ioctl_send() warn: check 'sctx->clone_roots[sctx->clone_roots_cnt++]' for negative offsets 'sctx->clone_roots_cnt' = 140002303859088.  extra = 's32min-s32max'
net/ipv4/ip_options.c:547 ip_forward_options() warn: check 'optptr[optptr[2] - 5]' for negative offsets 'optptr[2] - 5' = 140729597154752.  extra = 'unknown'
net/ipv4/ip_options.c:561 ip_forward_options() warn: check 'optptr[srrptr - 1]' for negative offsets 'srrptr - 1' = 139857025290384.  extra = 'unknown'
net/ipv4/ip_options.c:567 ip_forward_options() warn: check 'optptr[srrptr - 1]' for negative offsets 'srrptr - 1' = 139857023710736.  extra = 'unknown'
net/ipv4/ip_options.c:575 ip_forward_options() warn: check 'optptr[optptr[2] - 9]' for negative offsets 'optptr[2] - 9' = 139857021970448.  extra = 'unknown'
net/ipv4/ip_options.c:616 ip_options_rcv_srr() warn: check 'optptr[srrptr - 1]' for negative offsets 'srrptr - 1' = 139857024107536.  extra = 'unknown'
net/ipv4/ip_options.c:616 ip_options_rcv_srr() warn: check 'optptr[srrptr - 1]' for negative offsets 'srrptr - 1' = 139857023562768.  extra = 'unknown'
net/ipv4/ip_options.c:616 ip_options_rcv_srr() warn: check 'optptr[srrptr - 1]' for negative offsets 'srrptr - 1' = 139857020230032.  extra = 'unknown'
net/sctp/socket.c:7430 sctp_getsockopt_pr_assocstatus() warn: check 'asoc->abandoned_unsent[((policy >> 4) - 1)]' for negative offsets '(policy >> 4) - 1' = 139875963263760.  extra = 'unknown'
net/sctp/socket.c:7432 sctp_getsockopt_pr_assocstatus() warn: check 'asoc->abandoned_sent[((policy >> 4) - 1)]' for negative offsets '(policy >> 4) - 1' = 139875962396944.  extra = 'unknown'
net/sctp/socket.c:7499 sctp_getsockopt_pr_streamstatus() warn: check 'streamoute->abandoned_unsent[((policy >> 4) - 1)]' for negative offsets '(policy >> 4) - 1' = 139875959726736.  extra = 'unknown'
net/sctp/socket.c:7501 sctp_getsockopt_pr_streamstatus() warn: check 'streamoute->abandoned_sent[((policy >> 4) - 1)]' for negative offsets '(policy >> 4) - 1' = 139875958368400.  extra = 'unknown'
sound/soc/sof/ipc4-mtrace.c:374 sof_ipc4_priority_mask_dfs_write() warn: check 'priv->state_info.logs_priorities_mask[id]' for negative offsets 'id' = 139930792399632.  extra = 's32min-15'

--3VO4Cpa8YkOiSFt1--

