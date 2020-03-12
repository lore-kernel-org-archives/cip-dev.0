Return-Path: <SRS0=DIdx=45=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A5EC10DCE
	for <cip-dev@archiver.kernel.org>; Thu, 12 Mar 2020 09:07:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0151C206FA
	for <cip-dev@archiver.kernel.org>; Thu, 12 Mar 2020 09:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0151C206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BC72986090;
	Thu, 12 Mar 2020 09:07:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yj63pWhvHKfG; Thu, 12 Mar 2020 09:07:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 215D985D4C;
	Thu, 12 Mar 2020 09:07:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 029BCC0177;
	Thu, 12 Mar 2020 09:07:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C37CC0177;
 Thu, 12 Mar 2020 09:07:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 733DE85F81;
 Thu, 12 Mar 2020 09:07:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BdVjEPUfolr9; Thu, 12 Mar 2020 09:07:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mo-csw.securemx.jp (mo-csw1114.securemx.jp [210.130.202.156])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 76CA285D4C;
 Thu, 12 Mar 2020 09:07:34 +0000 (UTC)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 02C97Wtf019808;
 Thu, 12 Mar 2020 18:07:32 +0900
X-Iguazu-Qid: 2wHHK1VZoIyrXTq76Z
X-Iguazu-QSIG: v=2; s=0; t=1584004052; q=2wHHK1VZoIyrXTq76Z;
 m=XgcbIKul+M/TfS4K8YSYgCLcDB8x/E6lG/meTnZ7COI=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
 by relay.securemx.jp (mx-mr1112) id 02C97VNj035346;
 Thu, 12 Mar 2020 18:07:31 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
 by imx12.toshiba.co.jp  with ESMTP id 02C97VAj013558;
 Thu, 12 Mar 2020 18:07:31 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
 by enc02.toshiba.co.jp  with ESMTP id 02C97UUc023064;
 Thu, 12 Mar 2020 18:07:31 +0900
From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To: Kento Yoshida <kento.yoshida.wz@renesas.com>
References: <TYAPR01MB23996D34ED0281C405A6C34CDF1B0@TYAPR01MB2399.jpnprd01.prod.outlook.com>
 <87zhcphlav.fsf@kokedama.swc.toshiba.co.jp>
 <TYAPR01MB23997E05968D679F418D3649DFFD0@TYAPR01MB2399.jpnprd01.prod.outlook.com>
Date: Thu, 12 Mar 2020 18:07:29 +0900
In-Reply-To: <TYAPR01MB23997E05968D679F418D3649DFFD0@TYAPR01MB2399.jpnprd01.prod.outlook.com>
 (Kento Yoshida's message of "Thu, 12 Mar 2020 04:13:51 +0000")
X-TSB-HOP: ON
Message-ID: <87d09ieyb2.fsf@kokedama.swc.toshiba.co.jp>
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

SGkgWW9zaGlkYS1zYW4sCgpUaGFua3MgZm9yIHRoZSBjbGFyaWZpY2F0aW9ucy4gV2hlcmUgYXBw
bGljYWJsZSBwbGVhc2UgaW5jbHVkZSB0aGVtIGluCnRoZSByZXF1aXJlbWVudHMgdGV4dCBhbmQg
LyBvciBjb21tZW50cyBmb3IgdGhlIHJlbGV2YW50IHBhY2thZ2VzIGZvcgp0aGUgbmV4dCB1cGRh
dGUuCgpPbmUgYWRkaXRpb25hbCBjb21tZW50IGJlbG93IC0KCktlbnRvIFlvc2hpZGEgPGtlbnRv
Lnlvc2hpZGEud3pAcmVuZXNhcy5jb20+IHdyaXRlczoKClsuLi5dCgo+PiogdXVpZC1ydW50aW1l
Cj4+Cj4+SXTigJlzIG5vdCBjbGVhciBob3cgdGhlIHBhY2thZ2UgaXMgcmVsYXRlZCB0byB0aGUg
cmVxdWlyZW1lbnQgLQo+Pgo+PiAgICAiQWNjb3VudCBJZGVudGlmaWVyIHNoYWxsIGJlIHVuaXF1
ZSBvbiBhIGNvbXBvbmVudCBvciBzeXN0ZW0gd2lkZQo+PiAgICBsZXZlbC4gUHJvdGVjdGlvbiBv
ZiByZWxldmFudCBpbmZvcm1hdGlvbiBpbiByZXN0IGFuZCB0cmFuc2l0IHNoYWxsCj4+ICAgIGJl
IHN1cHBvcnRlZC4iCj4+Cj4+Q2FuIHlvdSBhZGQgbW9yZSBkZXRhaWxzIHRvIHRoZSByZXF1aXJl
bWVudCB0byBjbGFyaWZ5IHRoaXM/Cj4+Cj4gQXMgaXMsIGlkZW50aWZpZXIgc2hhbGwgYmUgdW5p
cXVlLCBzbyB3ZSBuZWVkIHVuaXZlcnNhbGx5IHVuaXF1ZSBpZGVudGlmaWVyIGdlbmVyYXRvci4K
PiBTb3JyeSBidXQgSSBkb24ndCBrbm93IHdoYXQgeW91IGRvbid0IGtub3cuIFRoaXMgaXMgdmVy
eSBzaW1wbGUKPiByZXF1aXJlbWVudC4KCkkgdW5kZXJzdGFuZCB0aGUgcmVxdWlyZW1lbnQgZm9y
IGhhdmluZyDigJl1bmlxdWUgYWNjb3VudCBpZGVudGlmaWVy4oCZCih1c2VybmFtZXMpIGJ1dCB1
c2luZyB1dWlkZ2VuIHRvIGFjaGlldmUgdGhpcyBzZWVtcyBxdWl0ZSBpbXByYWN0aWNhbC4KCkZv
ciByZWZlcmVuY2UsIEkgY2hlY2tlZCB0aGUgb3V0cHV0IG9mIHV1aWRnZW4gaW5jbHVkZWQgaW4g
dGhlIHBhY2thZ2UgLQoKICAgICQgdXVpZGdlbgogICAgYjg2NWMyNzgtNDIzMC00ZDVhLWI3ZGUt
MGVlNTI4OTEwMDk1CgpJdCBnZW5lcmF0ZXMgYSAzNyBjaGFyYWN0ZXIgbG9uZyBzdHJpbmcgb2Yg
d2hhdCBzZWVtcyBsaWtlIHJhbmRvbSBoZXgKdmFsdWVzLiBBcmUgeW91IHJlY29tbWVuZGluZyB0
aGF0IHdlIGhhdmUgdGhlc2Uga2luZCBvZiBzdHJpbmdzIGZvcgp1c2VybmFtZXM/CgpUaGFua3Ms
ClB1bml0Cgo+Cj4+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPj5Gcm9tOiBQdW5pdCBBZ3Jh
d2FsIDxwdW5pdDEuYWdyYXdhbEB0b3NoaWJhLmNvLmpwPgo+PlNlbnQ6IE1vbmRheSwgTWFyY2gg
OSwgMjAyMCA3OjMxIFBNCj4+VG86IEtlbnRvIFlvc2hpZGEgPGtlbnRvLnlvc2hpZGEud3pAcmVu
ZXNhcy5jb20+Cj4+Q2M6IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBjaXAtc2VjdXJp
dHlAbGlzdHMuY2lwLXByb2plY3Qub3JnCj4+U3ViamVjdDogUmU6IFtjaXAtZGV2XSBQYWNrYWdl
IFByb3Bvc2FsICMxIChTZWN1cml0eSBwYWNrYWdlcyksIHJldjAzCj4+Cj4+SGksCj4+Cj4+QXMg
bWVudGlvbmVkIGVhcmxpZXIsIEkgaGFkIHNvbWUgcXVlc3Rpb25zIC8gcXVlcmllcyByZWdhcmRp
bmcgdGhlIHJlcXVpcmVtZW50cwo+PmZvciB0aGUgcHJvcG9zZWQgcGFja2FnZXMuIFNlbmRpbmcg
dGhlbSBoZXJlIGZvciBkaXNjdXNzaW9uLgo+Pgo+PktlbnRvIFlvc2hpZGEgPGtlbnRvLnlvc2hp
ZGEud3pAcmVuZXNhcy5jb20+IHdyaXRlczoKPj4KPj4+ICBSZXF1aXJlbWVudHNfZm9yX3Byb3Bv
c2FsX1NlY3VyaXR5V0dfcmV2MDMueGxzeDogdGhlIHNhbWUgZmlsZSB3aGljaAo+Pj4gSSd2ZSBh
bHJlYWR5IHNlbnQgYmVmb3JlIHRvIGV4cGxhaW4gdGhlIHJlcXVpcmVtZW50IGluIHRoZSBzdGFu
ZGFyZAo+Pgo+Piogc3Vkby1sZGFwCj4+Cj4+SXMgdGhlcmUgYSBzcGVjaWZpYyByZXF1aXJlbWVu
dCB0byBpbmNsdWRlIHN1ZG8tbGRhcCBpbiBmYXZvdXIgb2YgcGxhaW4gc3Vkbz8gSUlVQywKPj5z
dWRvIGlzIGEgbWluaW1hbCBkZXBlbmRlbmN5IHZlcnNpb24gd2hpbGUgbGRhcCByZXF1aXJlcyBh
ZGRpdGlvbmFsIHBhY2thZ2VzIHRvCj4+YmUgYXZhaWxhYmxlLgo+Pgo+Pgo+Piogb3BlbnNzaAo+
Pgo+PkJhc2VkIG9uIHRoZSBsaXN0ZWQgcmVxdWllcm1lbnRzLCBpdCBpcyBub3QgY2xlYXIgd2h5
IGZ0cCBhbmQgc3NoIGNsaWVudHMgYXJlIG5lZWRlZC4KPj5DYW4geW91IHBsZWFzZSBjbGFyaWZ5
IHRoZSByZXF1aXJlbWVudHMnIHRleHQgdG8gbW90aXZhdGUgaW5jbHVzaW9uIG9mIHRoZSBjbGll
bnQKPj5iaW5hcmllcyBhcyB3ZWxsLgo+Pgo+Pgo+PiogcGFtLXBrY3MxMQo+Pgo+PkZyb20gbXkg
dW5kZXJzdGFuZGluZywgdGhlIHBhY2thZ2UgZW5hYmxlcyBsb2dpbiAgdXNpbmcgcHVibGljIC8g
cHJpdmF0ZSBrZXlzLgo+PkJ1dCB0aGUgcmVxdWlyZW1lbnRzIHRhbGsgYWJvdXQgZW5mb3JjaW5n
IHRoZSBzdHJlbmd0aCBvZiBwYXNzd29yZHMgLQo+Pgo+PiAgICAiQSBtaW5pbXVtIHN0cmVuZ3Ro
IG9mIHVzZWQgcGFzc3dvcmRzIG5lZWRzIHRvIGJlIGVuZm9yY2VkLiIKPj4KPj5Qb3NzaWJseSBh
IG1peHVwIG9mIHBhY2thZ2UgYW5kIHJlcXVpcmVtZW50cz8KPj4KPj4KPj4qIHRwbTIqCj4+Cj4+
SSB0aGluayBsaWJ0c3MyLWVzeXMwIGlzIG1pc3Rha2VubHkgaW5jbHVkZWQgYXMgZXhwbGljaXQg
cmVxdWlyZW1lbnQuIEl0IHNlZW1zIHRvIGJlIGEKPj5kZXBlbmRlbmN5IG9mIHRwbTItYWJybWQg
YW5kIHdpbGwgZ2V0IHB1bGxlZCBpbiBhdXRvbWF0aWNhbGx5IGFzIHBlciBteQo+PnVuZGVyc3Rh
bmRpbmcuCj4+Cj4+Cj4+KiB1dWlkLXJ1bnRpbWUKPj4KPj5JdOKAmXMgbm90IGNsZWFyIGhvdyB0
aGUgcGFja2FnZSBpcyByZWxhdGVkIHRvIHRoZSByZXF1aXJlbWVudCAtCj4+Cj4+ICAgICJBY2Nv
dW50IElkZW50aWZpZXIgc2hhbGwgYmUgdW5pcXVlIG9uIGEgY29tcG9uZW50IG9yIHN5c3RlbSB3
aWRlCj4+ICAgIGxldmVsLiBQcm90ZWN0aW9uIG9mIHJlbGV2YW50IGluZm9ybWF0aW9uIGluIHJl
c3QgYW5kIHRyYW5zaXQgc2hhbGwKPj4gICAgYmUgc3VwcG9ydGVkLiIKPj4KPj5DYW4geW91IGFk
ZCBtb3JlIGRldGFpbHMgdG8gdGhlIHJlcXVpcmVtZW50IHRvIGNsYXJpZnkgdGhpcz8KPj4tLS0K
Pj4KPj4KPj5UaGFua3MsCj4+UHVuaXQKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KY2lwLWRldiBtYWlsaW5nIGxpc3QKY2lwLWRldkBsaXN0cy5jaXAtcHJv
amVjdC5vcmcKaHR0cHM6Ly9saXN0cy5jaXAtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9j
aXAtZGV2Cg==
