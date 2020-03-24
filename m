Return-Path: <SRS0=yIDp=5J=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E75C10DCE
	for <cip-dev@archiver.kernel.org>; Tue, 24 Mar 2020 06:12:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5E1320719
	for <cip-dev@archiver.kernel.org>; Tue, 24 Mar 2020 06:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E1320719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6ED12850DC;
	Tue, 24 Mar 2020 06:12:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tTRGaIT0EVIu; Tue, 24 Mar 2020 06:12:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2789B850D6;
	Tue, 24 Mar 2020 06:12:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 090BEC0177;
	Tue, 24 Mar 2020 06:12:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D42B1C0177
 for <cip-dev@lists.cip-project.org>; Tue, 24 Mar 2020 06:12:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C96CE204AB
 for <cip-dev@lists.cip-project.org>; Tue, 24 Mar 2020 06:12:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DeCIVx9MP9dk for <cip-dev@lists.cip-project.org>;
 Tue, 24 Mar 2020 06:12:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by silver.osuosl.org (Postfix) with ESMTPS id 80DD320130
 for <cip-dev@lists.cip-project.org>; Tue, 24 Mar 2020 06:12:07 +0000 (UTC)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
 by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 02O6C410012115
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2020 07:12:04 +0100
Received: from [139.22.35.139] ([139.22.35.139])
 by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 02O6C3d9018553;
 Tue, 24 Mar 2020 07:12:04 +0100
To: =?UTF-8?Q?Andreas_Wei=c3=9fel?= <andreas.weissel@gmail.com>,
 cip-dev@lists.cip-project.org
References: <CAC4QREfMtM1MQBVf2ZhRbBstUkCBbny5pwWEd_dJ09GcQpyiHA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <fc23117d-9d46-0765-ccb7-640b685824d2@siemens.com>
Date: Tue, 24 Mar 2020 07:12:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAC4QREfMtM1MQBVf2ZhRbBstUkCBbny5pwWEd_dJ09GcQpyiHA@mail.gmail.com>
Content-Language: en-US
Subject: Re: [cip-dev] Super long-term kernel support
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

T24gMjMuMDMuMjAgMTc6NTQsIEFuZHJlYXMgV2Vpw59lbCB3cm90ZToKPiBIaSBDSVAga2VybmVs
IHRlYW0sCj4gCj4gSSBoYXZlIGEgcXVlc3Rpb24gcmVnYXJkaW5nIHRoZSBzdXBlciBsb25nLXRl
cm0ga2VybmVsIHN1cHBvcnQ6IGNhbgo+IG90aGVyIGNvbW1lcmNpYWwgb3Igbm9uLWNvbW1lcmNp
YWwgcHJvamVjdHMgbWFrZSB1c2Ugb2Ygc3VjaCBrZXJuZWwKPiB2ZXJzaW9ucyBsaWtlICJsaW51
eC00LjE5LnktY2lwIiwgaS5lLiwgdXNlIHRoZSBDSVAgZ2l0IHJlcG9zaXRvcmllcwo+IHRvIGFk
ZHJlc3Mgc2VjdXJpdHkgaXNzdWVzIChDVkVzKSBpbiB0aGUgTGludXgga2VybmVsIGV2ZW4gYWZ0
ZXIgdGhlCj4gdXBzdHJlYW0gbG9uZy10ZXJtIHZlcnNpb25zIGFyZSBubyBsb25nZXIgc3VwcG9y
dGVkLCBvciBpcyB0aGlzCj4gY29uc2lkZXJlZCBhIHNlcnZpY2UgZm9yIG1lbWJlcnMgb25seT8K
CkFzIFBhdmVsIGFscmVhZHkgcG9pbnRlZCBvdXQ6IFRoZSBDSVAga2VybmVsIG5hdHVyYWxseSBy
ZW1haW5zIGEgR1BMIApwcm9qZWN0LCB1c2FnZSBpcyBmcmVlIHVuZGVyIHRoZSB0ZXJtcyBvZiB0
aGlzIGxpY2Vuc2UuCgpUaGUgYmVuZWZpdHMgb2YgYmVpbmcgYSBDSVAgbWVtYmVyIC0gYmVzaWRl
cyBlbnN1cmluZyB0aGUgZnVuZGluZyBvZiAKdGhpcyB3b3JrIC0gaXMgdGhlIGNoYW5jZSB0byBp
bmZsdWVuY2Ugd2hpY2ggY29uZmlndXJhdGlvbnMgYW5kLCB0aHVzLCAKc3Vic3lzdGVtcyB0aGUg
Q0lQIGtlcm5lbCB3aWxsIHN1cHBvcnQsIGFuZCBvbiB3aGljaCBoYXJkd2FyZS4KCkJlc3QgcmVn
YXJkcywKSmFuCgotLSAKU2llbWVucyBBRywgQ29ycG9yYXRlIFRlY2hub2xvZ3ksIENUIFJEQSBJ
T1QgU0VTLURFCkNvcnBvcmF0ZSBDb21wZXRlbmNlIENlbnRlciBFbWJlZGRlZCBMaW51eApfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpjaXAtZGV2IG1haWxp
bmcgbGlzdApjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZwpodHRwczovL2xpc3RzLmNpcC1w
cm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2NpcC1kZXYK
