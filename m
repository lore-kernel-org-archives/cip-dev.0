Return-Path: <SRS0=9jx6=42=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6B1C10F29
	for <cip-dev@archiver.kernel.org>; Mon,  9 Mar 2020 10:31:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDB0120828
	for <cip-dev@archiver.kernel.org>; Mon,  9 Mar 2020 10:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB0120828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A81FB884DD;
	Mon,  9 Mar 2020 10:31:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fYBBV0RdrNgU; Mon,  9 Mar 2020 10:31:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2716E88386;
	Mon,  9 Mar 2020 10:31:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04EEFC0177;
	Mon,  9 Mar 2020 10:31:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0906C0177;
 Mon,  9 Mar 2020 10:31:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 790F6883A8;
 Mon,  9 Mar 2020 10:31:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gMyG6KejlMqQ; Mon,  9 Mar 2020 10:31:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mo-csw.securemx.jp (mo-csw1115.securemx.jp [210.130.202.157])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9789D88386;
 Mon,  9 Mar 2020 10:31:08 +0000 (UTC)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 029AV6r8031577;
 Mon, 9 Mar 2020 19:31:06 +0900
X-Iguazu-Qid: 2wHHK1VZoDyrGJ0yVU
X-Iguazu-QSIG: v=2; s=0; t=1583749866; q=2wHHK1VZoDyrGJ0yVU;
 m=pd0GxmQUI7axV9obExtBJ9Fkkf+SCv08rCbFucoHagk=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
 by relay.securemx.jp (mx-mr1110) id 029AV5Tm006615;
 Mon, 9 Mar 2020 19:31:05 +0900
Received: from enc01.localdomain ([106.186.93.100])
 by imx2.toshiba.co.jp  with ESMTP id 029AV52s023417;
 Mon, 9 Mar 2020 19:31:05 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
 by enc01.localdomain  with ESMTP id 029AV5QL005522;
 Mon, 9 Mar 2020 19:31:05 +0900
From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To: Kento Yoshida <kento.yoshida.wz@renesas.com>
References: <TYAPR01MB23996D34ED0281C405A6C34CDF1B0@TYAPR01MB2399.jpnprd01.prod.outlook.com>
Date: Mon, 09 Mar 2020 19:31:04 +0900
In-Reply-To: <TYAPR01MB23996D34ED0281C405A6C34CDF1B0@TYAPR01MB2399.jpnprd01.prod.outlook.com>
 (Kento Yoshida's message of "Wed, 12 Feb 2020 01:06:04 +0000")
X-TSB-HOP: ON
Message-ID: <87zhcphlav.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Cc: "cip-security@lists.cip-project.org" <cip-security@lists.cip-project.org>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Package Proposal #1 (Security packages), rev03
X-BeenThere: cip-dev@lists.cip-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: <cip-dev.lists.cip-project.org>
List-Unsubscribe: <https://lists.cip-project.org/mailman/options/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=unsubscribe>
List-Archive: <http://lists.cip-project.org/pipermail/cip-dev/>
List-Post: <mailto:cip-dev@lists.cip-project.org>
List-Help: <mailto:cip-dev-request@lists.cip-project.org?subject=help>
List-Subscribe: <https://lists.cip-project.org/mailman/listinfo/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>

SGksCgpBcyBtZW50aW9uZWQgZWFybGllciwgSSBoYWQgc29tZSBxdWVzdGlvbnMgLyBxdWVyaWVz
IHJlZ2FyZGluZyB0aGUKcmVxdWlyZW1lbnRzIGZvciB0aGUgcHJvcG9zZWQgcGFja2FnZXMuIFNl
bmRpbmcgdGhlbSBoZXJlIGZvcgpkaXNjdXNzaW9uLgoKS2VudG8gWW9zaGlkYSA8a2VudG8ueW9z
aGlkYS53ekByZW5lc2FzLmNvbT4gd3JpdGVzOgoKPiAgUmVxdWlyZW1lbnRzX2Zvcl9wcm9wb3Nh
bF9TZWN1cml0eVdHX3JldjAzLnhsc3g6IHRoZSBzYW1lIGZpbGUgd2hpY2ggSSd2ZSBhbHJlYWR5
IHNlbnQgYmVmb3JlIHRvIGV4cGxhaW4gdGhlIHJlcXVpcmVtZW50IGluIHRoZSBzdGFuZGFyZAoK
KiBzdWRvLWxkYXAKCklzIHRoZXJlIGEgc3BlY2lmaWMgcmVxdWlyZW1lbnQgdG8gaW5jbHVkZSBz
dWRvLWxkYXAgaW4gZmF2b3VyIG9mIHBsYWluCnN1ZG8/IElJVUMsIHN1ZG8gaXMgYSBtaW5pbWFs
IGRlcGVuZGVuY3kgdmVyc2lvbiB3aGlsZSBsZGFwIHJlcXVpcmVzCmFkZGl0aW9uYWwgcGFja2Fn
ZXMgdG8gYmUgYXZhaWxhYmxlLgoKCiogb3BlbnNzaAoKQmFzZWQgb24gdGhlIGxpc3RlZCByZXF1
aWVybWVudHMsIGl0IGlzIG5vdCBjbGVhciB3aHkgZnRwIGFuZCBzc2gKY2xpZW50cyBhcmUgbmVl
ZGVkLiBDYW4geW91IHBsZWFzZSBjbGFyaWZ5IHRoZSByZXF1aXJlbWVudHMnIHRleHQgdG8KbW90
aXZhdGUgaW5jbHVzaW9uIG9mIHRoZSBjbGllbnQgYmluYXJpZXMgYXMgd2VsbC4KCgoqIHBhbS1w
a2NzMTEKCkZyb20gbXkgdW5kZXJzdGFuZGluZywgdGhlIHBhY2thZ2UgZW5hYmxlcyBsb2dpbiAg
dXNpbmcgcHVibGljIC8gcHJpdmF0ZQprZXlzLiBCdXQgdGhlIHJlcXVpcmVtZW50cyB0YWxrIGFi
b3V0IGVuZm9yY2luZyB0aGUgc3RyZW5ndGggb2YKcGFzc3dvcmRzIC0KCiAgICAiQSBtaW5pbXVt
IHN0cmVuZ3RoIG9mIHVzZWQgcGFzc3dvcmRzIG5lZWRzIHRvIGJlIGVuZm9yY2VkLiIKClBvc3Np
Ymx5IGEgbWl4dXAgb2YgcGFja2FnZSBhbmQgcmVxdWlyZW1lbnRzPwoKCiogdHBtMioKCkkgdGhp
bmsgbGlidHNzMi1lc3lzMCBpcyBtaXN0YWtlbmx5IGluY2x1ZGVkIGFzIGV4cGxpY2l0IHJlcXVp
cmVtZW50LiBJdApzZWVtcyB0byBiZSBhIGRlcGVuZGVuY3kgb2YgdHBtMi1hYnJtZCBhbmQgd2ls
bCBnZXQgcHVsbGVkIGluCmF1dG9tYXRpY2FsbHkgYXMgcGVyIG15IHVuZGVyc3RhbmRpbmcuCgoK
KiB1dWlkLXJ1bnRpbWUKCkl04oCZcyBub3QgY2xlYXIgaG93IHRoZSBwYWNrYWdlIGlzIHJlbGF0
ZWQgdG8gdGhlIHJlcXVpcmVtZW50IC0KCiAgICAiQWNjb3VudCBJZGVudGlmaWVyIHNoYWxsIGJl
IHVuaXF1ZSBvbiBhIGNvbXBvbmVudCBvciBzeXN0ZW0gd2lkZQogICAgbGV2ZWwuIFByb3RlY3Rp
b24gb2YgcmVsZXZhbnQgaW5mb3JtYXRpb24gaW4gcmVzdCBhbmQgdHJhbnNpdCBzaGFsbAogICAg
YmUgc3VwcG9ydGVkLiIKCkNhbiB5b3UgYWRkIG1vcmUgZGV0YWlscyB0byB0aGUgcmVxdWlyZW1l
bnQgdG8gY2xhcmlmeSB0aGlzPwotLS0KCgpUaGFua3MsClB1bml0Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmNpcC1kZXYgbWFpbGluZyBsaXN0CmNpcC1k
ZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnCmh0dHBzOi8vbGlzdHMuY2lwLXByb2plY3Qub3JnL21h
aWxtYW4vbGlzdGluZm8vY2lwLWRldgo=
