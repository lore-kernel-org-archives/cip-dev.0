Return-Path: <SRS0=NiLz=5D=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B81C10DCE
	for <cip-dev@archiver.kernel.org>; Wed, 18 Mar 2020 16:12:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 006B020714
	for <cip-dev@archiver.kernel.org>; Wed, 18 Mar 2020 16:12:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006B020714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id ABFA68817D;
	Wed, 18 Mar 2020 16:12:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vMvdEH+7-Hny; Wed, 18 Mar 2020 16:12:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0293C88179;
	Wed, 18 Mar 2020 16:12:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7338C013E;
	Wed, 18 Mar 2020 16:12:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28C99C013E
 for <cip-dev@lists.cip-project.org>; Wed, 18 Mar 2020 16:12:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 12CFC203EA
 for <cip-dev@lists.cip-project.org>; Wed, 18 Mar 2020 16:12:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YkijFQwGRj-v for <cip-dev@lists.cip-project.org>;
 Wed, 18 Mar 2020 16:12:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by silver.osuosl.org (Postfix) with ESMTPS id 9E72B20384
 for <cip-dev@lists.cip-project.org>; Wed, 18 Mar 2020 16:12:37 +0000 (UTC)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
 by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 02IGCYJm018481
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Mar 2020 17:12:34 +0100
Received: from [139.22.45.152] ([139.22.45.152])
 by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 02IGCXck014849;
 Wed, 18 Mar 2020 17:12:33 +0100
To: Chris Paterson <Chris.Paterson2@renesas.com>,
 "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
References: <OSAPR01MB3667C30E9485E66332CE184492F70@OSAPR01MB3667.jpnprd01.prod.outlook.com>
 <TYAPR01MB2285C867ACB9D7E7C7173901B7F70@TYAPR01MB2285.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <78ae767e-941f-7015-03d0-1385ce607cb4@siemens.com>
Date: Wed, 18 Mar 2020 17:12:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <TYAPR01MB2285C867ACB9D7E7C7173901B7F70@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Content-Language: en-US
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Please check health for renesas board on LAVA
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>

T24gMTguMDMuMjAgMTA6MTMsIENocmlzIFBhdGVyc29uIHdyb3RlOgo+IEhlbGxvIEl3YW1hdHN1
LXNhbiwKPiAKPj4gRnJvbTogbm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanAKPj4gPG5v
YnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPgo+PiBTZW50OiAxOCBNYXJjaCAyMDIwIDA1
OjQyCj4+Cj4+IEhpIENocmlzLAo+Pgo+PiBTb21lIFJlbmVzYXMgYm9hcmRzIGxvb2sgbGlrZSBk
b3duWzBdLgo+PiBUaGVyZWZvcmUsIHRlc3Rpbmcgd2l0aCBnaXRsYWIgaGFzIG5vdCBiZWVuIGNv
bXBsZXRlZC4KPiAKPiBZZXMsIHNvcnJ5LiBUaGVyZSBpcyBhbiBpc3N1ZSB3aXRoIG9uZSBvZiB0
aGUgVVNCIGh1YnMuCj4gSG93ZXZlciB3ZSdyZSBhbGwgd29ya2luZyBmcm9tIGhvbWUgYXQgdGhl
IG1vbWVudCBzbyBpdCdzIG5vdCBlYXN5IGZvciBtZSB0byBnZXQgcGh5c2ljYWwgYWNjZXNzLgo+
IAo+IEFzIGEgdGVtcG9yYXJ5IG1lYXN1cmUgeWVzdGVyZGF5IEkgcmVtb3ZlZCB0aGUgcHJvYmxl
bWF0aWMgYm9hcmRzIGZyb20gb3VyIENJIHBpcGVsaW5lcywgc28gaG9wZWZ1bGx5IGdvaW5nIGZv
cndhcmQgd2Ugc2hvdWxkIGJlIG9rYXkuCj4gVGhlIG9mZmxpbmUgYm9hcmRzIHdlcmUgYWRkaXRp
b25hbCBub24gQ0lQIHJlZmVyZW5jZSBwbGF0Zm9ybXMsIHNvIG91ciBDSSB3aWxsIHN0aWxsIGJl
IHRlc3Rpbmcgd2hhdCBuZWVkcyB0byBiZSB0ZXN0ZWQuCj4gCj4gVGhpcyBhZGRzIHRvIG15IHBv
aW50IHRoYXQgd2UgbmVlZCB0byBzcHJlYWQgcmVmZXJlbmNlIHBsYXRmb3JtcyBvdmVyIG1vcmUg
dGhlbiBvbmUgbG9jYXRpb24g8J+Yigo+IAoKLi4ueWVhaCwgYW5kIGF0IGxlYXN0IG9uZSBzaXRl
IHNob3VsZCBiZSBvbiB0aGUgbW9vbiAtIGluIGNhc2Ugb2YgCmFub3RoZXIgd2lkZS1zcHJlYWQg
bG9ja2Rvd24uIDspCgpKYW4KCi0tIApTaWVtZW5zIEFHLCBDb3Jwb3JhdGUgVGVjaG5vbG9neSwg
Q1QgUkRBIElPVCBTRVMtREUKQ29ycG9yYXRlIENvbXBldGVuY2UgQ2VudGVyIEVtYmVkZGVkIExp
bnV4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmNpcC1k
ZXYgbWFpbGluZyBsaXN0CmNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnCmh0dHBzOi8vbGlz
dHMuY2lwLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vY2lwLWRldgo=
