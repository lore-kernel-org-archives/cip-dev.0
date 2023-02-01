Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D19AC05027
	for <webhook@archiver.kernel.org>; Wed,  1 Feb 2023 14:01:22 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.23633.1675259977457385824
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Feb 2023 05:59:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=YbRu4Db6;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: error27@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso1444661wmp.3
        for <cip-dev@lists.cip-project.org>; Wed, 01 Feb 2023 05:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vPPhfK11XuWT5o2AnracjVCRCdVjvihnB+59xfLZCqM=;
        b=YbRu4Db6yu2Mq6VUJsZlrhpNZnOVfeEK3JjQu+FfIql9de6G5O3HJhoKoOe62L9Q3R
         e53O53rimDnuSaBTUD6ZNUBWmlT13vNe3ymVDNG+mDwmWLEswIdXj9/YNDZ5szuO1WkD
         K4i+zfd/fwIMGj+NJGvGLv5jMejS7zthBFlGXzhc7S79l/DSK0CbTJQti7DDCmR2ezU0
         f2jjUaATjKAgz/wg+sjqJBXCtGn5Tj/lDiRWOkxFf5Gc3bNc/92ZdLXsljnjqU6E97jo
         LiutGHzfNnNtmIZG2dC0sORVkEwTGSNpIEsfKryQxjT1KriIJfEkJI22sazfO9D05THR
         PKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPPhfK11XuWT5o2AnracjVCRCdVjvihnB+59xfLZCqM=;
        b=ltj8iI0ml2LCNILsjkY/4IoPauG9yjzwlCpaPTI/KsutkPDsrOrwimW10k5ZJhtabH
         zJp9rcFDaEhnjQoC4kFFPSW2scoT8/EvESOZZrSbOwSJmJKWwXJ6HlFJKtfIAuZ65WVj
         Gm4/1H9lf16hwK/7ae9n8xkoAXEyyk6rYylaCdQKt+4Cc61MzoR9t8AbYUJ/+AAdNCF7
         i+rMsUuYp8KTJwvs5JZddGeaC75eFj8MC5ug0Uu+T3tUr9iEEv69j6FJBMCLqp0qcyVn
         UpCkvNXQ1QiJEXzaeftVH0wA+qHKZmU7aUwf/QO/J/sqXXJaEA9zAskPITlsfwPJV+6j
         MQKg==
X-Gm-Message-State: AO0yUKVshoaLdtcATSzsbtXn2KoHtwZBMGyPrz69T/JL7pt31aLB790Y
	0iypKHEdCFZzEMGqDkSfCXw=
X-Google-Smtp-Source: AK7set+n3OW0J21JYV2duRee5aCYOZNvq7+8w3shubMQUwcRtw4iqHYSC8kPFxFTJgjpJEedsTn2bA==
X-Received: by 2002:a1c:7214:0:b0:3da:2500:e702 with SMTP id n20-20020a1c7214000000b003da2500e702mr1904443wmc.32.1675259975726;
        Wed, 01 Feb 2023 05:59:35 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o37-20020a05600c512500b003c6bbe910fdsm2122105wms.9.2023.02.01.05.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 05:59:35 -0800 (PST)
Date: Wed, 1 Feb 2023 16:59:29 +0300
From: Dan Carpenter <error27@gmail.com>
To: Masami Ichikawa <masami.ichikawa@miraclelinux.com>,
	Jason Wang <jasowang@redhat.com>
Cc: cip-dev <cip-dev@lists.cip-project.org>
Subject: Re: New CVE entries this week
Message-ID: <Y9pwQZ4UBD1FASVR@kadam>
References: <CAODzB9phGdgNo0dOTHLyovXP7Gcj9EgR1QDHHaNrAXhBxrHQzg@mail.gmail.com>
 <Y9oePa50jnpgnutu@kili>
MIME-Version: 1.0
In-Reply-To: <Y9oePa50jnpgnutu@kili>
Content-Type: multipart/mixed; boundary="khZS3rvjTdbMkp0H"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 Feb 2023 14:01:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10558

--khZS3rvjTdbMkp0H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

It turned out fairly easy to write this check.  There are now just 48
warnings so that's not too bad.  I'm attaching the list and the code
to generate it.  I'm trying to involve more people in analyzing Smatch
warnings so I'm going to explain how I read these in depth below.

This is the most interesting warning.  I've added Jason Wang to the
CC list because he knows the code better than I would.

drivers/net/tap.c:1227 tap_sendmsg() warn: uncapped user loop index 'i'
  1216  static int tap_sendmsg(struct socket *sock, struct msghdr *m,
  1217                         size_t total_len)
  1218  {
  1219          struct tap_queue *q = container_of(sock, struct tap_queue, sock);
  1220          struct tun_msg_ctl *ctl = m->msg_control;
  1221          struct xdp_buff *xdp;
  1222          int i;
  1223  
  1224          if (m->msg_controllen == sizeof(struct tun_msg_ctl) &&
  1225              ctl && ctl->type == TUN_MSG_PTR) {
  1226                  for (i = 0; i < ctl->num; i++) {
  1227                          xdp = &((struct xdp_buff *)ctl->ptr)[i];
  1228                          tap_get_user_xdp(q, xdp);
  1229                  }
  1230                  return 0;
  1231          }
  1232  
  1233          return tap_get_user(q, ctl ? ctl->ptr : NULL, &m->msg_iter,
  1234                              m->msg_flags & MSG_DONTWAIT);
  1235  }
Here Smatch thinks m->msg_control is controlled by the user because of
this code from ____sys_sendmsg():
net/socket.c
  2479                  if (copy_from_user(ctl_buf, msg_sys->msg_control_user, ctl_len))
  2480                          goto out_freectl;
  2481                  msg_sys->msg_control = ctl_buf;
                        ^^^^^^^^^^^^^^^^^^^^
Of course this would be a very serious bug if it's real, but I don't
have the expertise to evaluate it properly.

drivers/char/agp/generic.c:271 agp_allocate_memory() warn: uncapped user loop index 'i'
   248          scratch_pages = (page_count + ENTRIES_PER_PAGE - 1) / ENTRIES_PER_PAGE;
   249  
   250          new = agp_create_memory(scratch_pages);
	...
   264          for (i = 0; i < page_count; i++) {
	...
   271                  new->pages[i] = page;

In this code, we allocate "scratch_pages" number of pages.  Smatch does
not understand that properly track the relationship between page_count
and scratch_pages or the relationship between scratch_pages and
new->pages.  Two things which should be fixed.

drivers/dma/qcom/hidma_mgmt.c:101 hidma_mgmt_setup() warn: uncapped user loop index 'i'
This is the first real bug, but it's root only so it's not a security
issue.  I have reported it.

drivers/comedi/comedi_fops.c:1445 parse_insn() warn: uncapped user loop index 'i'
If you look at do_insn_ioctl() the size of the "data" array is "n_data"
and "n_data" is more than "insn->n".  Smatch tries to track when a
variable *is* the array size, but I don't think we will track that the
ariable is less than the array size across function boundaries.

drivers/net/can/sun4i_can.c:458 sun4ican_start_xmit() warn: uncapped user loop index 'i'
CAN is problematic for Smatch because when it recieves a packet it take
skb->data (which is a buffer of u8) and then checks it and then stuffs
it back into the buffer of u8.  When the buffer gets stuffed back into
skb->data then the details about how it was checked are lost.  Probably
it's safe to ignore all 8 drivers/net/can/ warnings.

drivers/net/wireless/ath/ath10k/htt_rx.c:2988 ath10k_htt_rx_tx_compl_ind() warn: uncapped user loop index 'i'
Smatch assumes that every skb->data holds untrusted data.  One place
where this assumption fails is on the sending path.  I notice that this
function has both RX and TX in the name, so it might be a send path.
I do not know if this is a real bug or not.

drivers/net/wireless/ath/ath6kl/wmi.c:1304 ath6kl_wmi_neighbor_report_event_rx() warn: uncapped user loop index 'i'
  1287  static int ath6kl_wmi_neighbor_report_event_rx(struct wmi *wmi, u8 *datap,
  1288                                                 int len, struct ath6kl_vif *vif)
  1289  {
  1290          struct wmi_neighbor_report_event *ev;
  1291          u8 i;
  1292  
  1293          if (len < sizeof(*ev))
  1294                  return -EINVAL;
  1295          ev = (struct wmi_neighbor_report_event *) datap;
  1296          if (struct_size(ev, neighbor, ev->num_neighbors) > len) {
                                              ^^^^^^^^^^^^^^^^^
Smatch needs to be fixed to recognize that "ev->num_neighbors" is checked
here.  Fixable.

  1297                  ath6kl_dbg(ATH6KL_DBG_WMI,
  1298                             "truncated neighbor event (num=%d len=%d)\n",
  1299                             ev->num_neighbors, len);
  1300                  return -EINVAL;
  1301          }
  1302          for (i = 0; i < ev->num_neighbors; i++) {
  1303                  ath6kl_dbg(ATH6KL_DBG_WMI, "neighbor %d/%d - %pM 0x%x\n",
  1304                             i + 1, ev->num_neighbors, ev->neighbor[i].bssid,
  1305                             ev->neighbor[i].bss_flags);
  1306                  cfg80211_pmksa_candidate_notify(vif->ndev, i,
  1307                                                  ev->neighbor[i].bssid,
  1308                                                  !!(ev->neighbor[i].bss_flags &
  1309                                                     WMI_PREAUTH_CAPABLE_BSS),
  1310                                                  GFP_ATOMIC);
  1311          }
  1312  
  1313          return 0;
  1314  }

drivers/net/wireless/quantenna/qtnfmac/commands.c:1100 qtnf_parse_variable_mac_info() warn: uncapped user loop index 'i'
  1079                          rec_len = sizeof(*rec) + rec->n_limits * sizeof(*lim);
  1080  
  1081                          if (unlikely(tlv_value_len != rec_len)) {
Another false positive.  This bounds checking on "rec->n_limits" was too
complicated for Smatch.

drivers/net/ethernet/mediatek/mtk_wed_mcu.c:82 mtk_wed_update_rx_stats() warn: uncapped user loop index 'i'
    64  static void
    65  mtk_wed_update_rx_stats(struct mtk_wed_device *wed, struct sk_buff *skb)
    66  {
    67          u32 count = get_unaligned_le32(skb->data);
    68          struct mtk_wed_wo_rx_stats *stats;
    69          int i;
    70  
    71          if (count * sizeof(*stats) > skb->len - sizeof(u32))
    72                  return;
    73  
    74          stats = (struct mtk_wed_wo_rx_stats *)(skb->data + sizeof(u32));
    75          for (i = 0 ; i < count ; i++)
    76                  wed->wlan.update_wo_rx_stats(wed, &stats[i]);
    77  }
The bounds checking is too complicated for Smatch, but also this code
is buggy.  Bug 1: There is no check to ensure that skb->len >= sizeof(u32).
Bug 2: On a 32 bit system the "count * sizeof(*stats)" multiplication
can lead to an integer overflow.  I have reported these bugs.

regards,
dan carpenter

--khZS3rvjTdbMkp0H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=err-list

drivers/char/agp/generic.c:271 agp_allocate_memory() warn: uncapped user loop index 'i'
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_events.c:948 kfd_wait_on_events() warn: uncapped user loop index 'i'
drivers/gpu/drm/msm/msm_gem_submit.c:966 msm_ioctl_gem_submit() warn: uncapped user loop index 'i'
drivers/gpu/drm/msm/msm_gem_submit.c:974 msm_ioctl_gem_submit() warn: uncapped user loop index 'i'
drivers/dma/qcom/hidma_mgmt.c:101 hidma_mgmt_setup() warn: uncapped user loop index 'i'
drivers/comedi/comedi_fops.c:1445 parse_insn() warn: uncapped user loop index 'i'
drivers/net/can/sun4i_can.c:458 sun4ican_start_xmit() warn: uncapped user loop index 'i'
drivers/net/can/usb/esd_usb.c:769 esd_usb_start_xmit() warn: uncapped user loop index 'i'
drivers/net/can/usb/ems_usb.c:780 ems_usb_start_xmit() warn: uncapped user loop index 'i'
drivers/net/can/cc770/cc770.c:419 cc770_tx() warn: uncapped user loop index 'i'
drivers/net/can/slcan/slcan-core.c:521 slcan_encaps() warn: uncapped user loop index 'i'
drivers/net/can/rcar/rcar_can.c:605 rcar_can_start_xmit() warn: uncapped user loop index 'i'
drivers/net/can/sja1000/sja1000.c:321 sja1000_start_xmit() warn: uncapped user loop index 'i'
drivers/net/wireless/ath/ath10k/htt_rx.c:2988 ath10k_htt_rx_tx_compl_ind() warn: uncapped user loop index 'i'
drivers/net/wireless/ath/ath10k/htt_rx.c:3427 ath10k_htt_rx_tx_fetch_ind() warn: uncapped user loop index 'i'
drivers/net/wireless/ath/ath6kl/wmi.c:1304 ath6kl_wmi_neighbor_report_event_rx() warn: uncapped user loop index 'i'
drivers/net/wireless/quantenna/qtnfmac/commands.c:1100 qtnf_parse_variable_mac_info() warn: uncapped user loop index 'i'
drivers/net/ethernet/mediatek/mtk_wed_mcu.c:82 mtk_wed_update_rx_stats() warn: uncapped user loop index 'i'
drivers/net/tap.c:1227 tap_sendmsg() warn: uncapped user loop index 'i'
drivers/net/amt.c:1417 amt_add_srcs() warn: uncapped user loop index 'i'
drivers/net/amt.c:1420 amt_add_srcs() warn: uncapped user loop index 'i'
drivers/net/amt.c:1505 amt_lookup_act_srcs() warn: uncapped user loop index 'i'
drivers/net/amt.c:1508 amt_lookup_act_srcs() warn: uncapped user loop index 'i'
drivers/net/amt.c:1528 amt_lookup_act_srcs() warn: uncapped user loop index 'i'
drivers/net/amt.c:1531 amt_lookup_act_srcs() warn: uncapped user loop index 'i'
drivers/net/amt.c:1549 amt_lookup_act_srcs() warn: uncapped user loop index 'j'
drivers/net/amt.c:1552 amt_lookup_act_srcs() warn: uncapped user loop index 'j'
drivers/net/amt.c:1570 amt_lookup_act_srcs() warn: uncapped user loop index 'i'
drivers/net/amt.c:1573 amt_lookup_act_srcs() warn: uncapped user loop index 'i'
drivers/xen/gntalloc.c:152 add_grefs() warn: uncapped user loop index 'i'
drivers/xen/gntdev.c:974 gntdev_ioctl_grant_copy() warn: uncapped user loop index 'i'
fs/btrfs/send.c:7998 flush_delalloc_roots() warn: uncapped user loop index 'i'
fs/nfs/dir.c:226 nfs_readdir_clear_array() warn: uncapped user loop index 'i'
fs/nfs/dir.c:547 nfs_readdir_search_for_cookie() warn: uncapped user loop index 'i'
fs/nfsd/export.c:326 nfsd4_fslocs_free() warn: uncapped user loop index 'i'
fs/remap_range.c:533 vfs_dedupe_file_range() warn: uncapped user loop index 'i'
arch/x86/kvm/svm/sev.c:545 sev_launch_update_data() warn: uncapped user loop index 'i'
net/can/isotp.c:345 check_pad() warn: uncapped user loop index 'i'
net/wireless/nl80211.c:5637 nl80211_check_ap_rate_selectors() warn: uncapped user loop index 'i'
net/sctp/outqueue.c:1236 sctp_sack_update_unack_data() warn: uncapped user loop index 'i'
net/sctp/outqueue.c:1796 sctp_acked() warn: uncapped user loop index 'i'
net/rxrpc/call_event.c:149 rxrpc_resend() warn: uncapped user loop index 'i'
net/bluetooth/hci_codec.c:158 hci_read_supported_codecs() warn: uncapped user loop index 'i'
net/bluetooth/hci_codec.c:178 hci_read_supported_codecs() warn: uncapped user loop index 'i'
net/bluetooth/hci_codec.c:227 hci_read_supported_codecs_v2() warn: uncapped user loop index 'i'
net/bluetooth/hci_codec.c:245 hci_read_supported_codecs_v2() warn: uncapped user loop index 'i'
net/bluetooth/mgmt.c:5375 parse_adv_monitor_pattern() warn: uncapped user loop index 'i'
net/ncsi/ncsi-rsp.c:938 ncsi_rsp_handler_gp() warn: uncapped user loop index 'i'

--khZS3rvjTdbMkp0H
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="check_user_loop_out_of_bounds.c"

/*
 * Copyright (C) 2019 Oracle.
 * Copyright (C) 2023 Dan Carpenter.
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

STATE(uncapped);

static struct expression *get_iterator(struct statement *stmt)
{
	struct expression *expr;

	if (!stmt ||
	    stmt->type != STMT_ITERATOR ||
	    !stmt->iterator_pre_statement ||
	    stmt->iterator_pre_statement->type != STMT_EXPRESSION)
		return NULL;

	expr = strip_expr(stmt->iterator_pre_statement->expression);
	if (!expr || expr->type != EXPR_ASSIGNMENT)
		return NULL;

	return strip_expr(expr->left);
}

static void match_condition(struct expression *expr)
{
	struct expression *iterator;
	struct statement *parent;
	struct range_list *rl;

	if (!__in_pre_condition || expr->type != EXPR_COMPARE)
		return;

	parent = expr_get_parent_stmt(expr);
	if (!parent)
		return;

	iterator = get_iterator(parent);
	if (!iterator)
		return;

	if (!get_user_rl(expr->right, &rl))
		return;

	if (!is_whole_rl(rl) || user_rl_capped(expr->right))
		return;

	set_true_false_states_expr(my_id, iterator, &uncapped, NULL);
}

static bool is_copy_from_user_src(struct expression *expr)
{
	struct expression *parent;
	struct expression *src;
	int cnt = 0;

	while (cnt++ < 10) {
		parent = expr_get_parent_expr(expr);
		if (!parent)
			return false;
		if (parent->type != EXPR_CALL ||
		    !sym_name_is("copy_from_user", parent->fn)) {
			expr = parent;
			continue;
		}
		src = get_argument_from_call_expr(parent->args, 1);
		src = strip_expr(src);
		expr = strip_expr(expr);
		return src == expr;
	}
	return false;
}

static void array_check(struct expression *expr)
{
	struct expression *array_expr, *idx;
	struct range_list *rl;
	int array_size;
	char *name;

	idx = get_array_offset(expr);
	if (get_state_expr(my_id, idx) != &uncapped)
		return;

	if (buf_comparison_index_ok(expr))
		return;

	get_absolute_rl(idx, &rl);

	array_expr = get_array_base(expr);
	array_size = get_array_size(array_expr);
	if (rl_max(rl).uvalue < array_size)
		return;

	if (is_copy_from_user_src(expr))
		return;

	name = expr_to_str(idx);
	sm_warning("uncapped user loop index '%s'", name);
	free_string(name);

	set_state_expr(my_id, idx, &undefined);
}

void check_user_loop_out_of_bounds(int id)
{
	my_id = id;

	add_hook(&match_condition, CONDITION_HOOK);
	add_hook(&array_check, OP_HOOK);
}

--khZS3rvjTdbMkp0H--

