Return-Path: <SRS0=bK8j=5P=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FACC43331
	for <cip-dev@archiver.kernel.org>; Mon, 30 Mar 2020 04:39:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA51F20786
	for <cip-dev@archiver.kernel.org>; Mon, 30 Mar 2020 04:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA51F20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A227185EA5;
	Mon, 30 Mar 2020 04:39:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O34PhUDdoD8p; Mon, 30 Mar 2020 04:39:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 10F5C85E9B;
	Mon, 30 Mar 2020 04:39:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB6BDC07FF;
	Mon, 30 Mar 2020 04:39:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75F78C07FF
 for <cip-dev@lists.cip-project.org>; Mon, 30 Mar 2020 04:39:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6598B85EA4
 for <cip-dev@lists.cip-project.org>; Mon, 30 Mar 2020 04:39:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YN3hZXtoIRGm for <cip-dev@lists.cip-project.org>;
 Mon, 30 Mar 2020 04:39:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mo-csw.securemx.jp (mo-csw1515.securemx.jp [210.130.202.154])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 65B3185E9B
 for <cip-dev@lists.cip-project.org>; Mon, 30 Mar 2020 04:39:01 +0000 (UTC)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 02U4csOQ024399;
 Mon, 30 Mar 2020 13:38:54 +0900
X-Iguazu-Qid: 34trWq5aw3qGsq5ZwG
X-Iguazu-QSIG: v=2; s=0; t=1585543134; q=34trWq5aw3qGsq5ZwG;
 m=24P0RYaeo69FDrQAz9EE4DXXbtIpax0ZWyw5Ob23+2g=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
 by relay.securemx.jp (mx-mr1511) id 02U4cqTX027042;
 Mon, 30 Mar 2020 13:38:53 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
 by imx12.toshiba.co.jp  with ESMTP id 02U4cqpw003904;
 Mon, 30 Mar 2020 13:38:52 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
 by enc02.toshiba.co.jp  with ESMTP id 02U4cqpI011807;
 Mon, 30 Mar 2020 13:38:52 +0900
From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To: Pavel Machek <pavel@ucw.cz>
References: <20200327075720.GA32000@duo.ucw.cz>
Date: Mon, 30 Mar 2020 13:38:44 +0900
In-Reply-To: <20200327075720.GA32000@duo.ucw.cz> (Pavel Machek's message of
 "Fri, 27 Mar 2020 08:57:20 +0100")
X-TSB-HOP: ON
Message-ID: <87wo725uej.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Cc: eperezma@redhat.com, davem@davemloft.net, stable@kernel.org,
 cip-dev@lists.cip-project.org, mst@redhat.com
Subject: Re: [cip-dev] [PATCH 4.4] vhost: Check docket sk_family instead of
	call getname
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

SGkgUGF2ZWwsCgpBIGNvdXBsZSBvZiBjb21tZW50cyBiZWxvdyAtCgpQYXZlbCBNYWNoZWsgPHBh
dmVsQHVjdy5jej4gd3JpdGVzOgoKPiBGcm9tOiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVk
aGF0LmNvbT4KPgo+IERvaW5nIHNvLCB3ZSBzYXZlIG9uZSBjYWxsIHRvIGdldCBkYXRhIHdlIGFs
cmVhZHkgaGF2ZSBpbiB0aGUgc3RydWN0Lgo+Cj4gQWxzbywgc2luY2UgdGhlcmUgaXMgbm8gZ3Vh
cmFudGVlIHRoYXQgZ2V0bmFtZSB1c2Ugc29ja2FkZHJfbGwKPiBwYXJhbWV0ZXIgYmV5b25kIGl0
cyBzaXplLCB3ZSBhZGQgYSBsaXR0bGUgYml0IG9mIHNlY3VyaXR5IGhlcmUuCj4gSXQgc2hvdWxk
IGRvIG5vdCBkbyBiZXlvbmQgTUFYX0FERFJfTEVOLCBidXQgc3l6Ym90IGZvdW5kIHRoYXQKPiBh
eDI1X2dldG5hbWUgd3JpdGVzIG1vcmUgKDcyIGJ5dGVzLCB0aGUgc2l6ZSBvZiBmdWxsX3NvY2th
ZGRyX2F4MjUsCj4gdmVyc3VzIDIwICsgMzIgYnl0ZXMgb2Ygc29ja2FkZHJfbGwgKyBNQVhfQURE
Ul9MRU4gaW4gc3l6Ym90IHJlcHJvKS4KPgo+IEZpeGVzOiAzYTRkNWM5NGU5NTkzICgidmhvc3Rf
bmV0OiBhIGtlcm5lbC1sZXZlbCB2aXJ0aW8gc2VydmVyIikKPiBSZXBvcnRlZC1ieTogc3l6Ym90
K2YyYTYyZDA3YTUxOThjODE5YzdiQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20KPiBTaWduZWQt
b2ZmLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiBBY2tlZC1ieTog
TWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBEYXZp
ZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+Cj4gVXBzdHJlYW06IDQyZDg0Yzg0OTBm
OWYwOTMxNzg2ZjE2MjMxOTFmY2FiMzk3YzNkNjQKClBsZWFzZSBmb2xsb3cgdGhlIHN0eWxlIGd1
aWRlbGluZXMgZG9jdW1lbnRlZCBpbgpEb2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3RhYmxlLWtlcm5l
bC1ydWxlcy5yc3QuIEluIHRoaXMgaW5zdGFuY2UsIHBsZWFzZQptZW50aW9uIHRoZSB1cHN0cmVh
bSBjb21taXQgaWQgZm9sbG93aW5nIC0KCiAgICBUaGUgdXBzdHJlYW0gY29tbWl0IElEIG11c3Qg
YmUgc3BlY2lmaWVkIHdpdGggYSBzZXBhcmF0ZSBsaW5lIGFib3ZlIHRoZQogICAgY29tbWl0CiAg
ICB0ZXh0LCBsaWtlIHRoaXM6CgogICAgICAgIGNvbW1pdCA8c2hhMT4gdXBzdHJlYW0uCgpGb3Ig
YW4gZXhhbXBsZSwgdGFrZSBhIGxvb2sgYXQgQ29tbWl0IGFkNTk4YTQ4ZmU2MSAoInZob3N0OiBD
aGVjayBkb2NrZXQKc2tfZmFtaWx5IGluc3RlYWQgb2YgY2FsbCBnZXRuYW1lIikuIEl0J3MgYSBi
YWNrcG9ydCBvZiB0aGUgc2FtZQp1cHN0cmVhbSBwYXRjaCB0byA0LjE5IHN0YWJsZSBrZXJuZWwu
Cgo+IFNpZ25lZC1vZmYtYnk6IFBhdmVsIE1hY2hlayA8cGF2ZWxAZGVueC5kZT4KPiAtLS0KPiAg
ZHJpdmVycy92aG9zdC9uZXQuYyB8IDEzICsrLS0tLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCj4KPiAtLS0KPgo+IFNpbmNlIGl0IGlz
IGEgc2VjdXJpdHkgcHJvYmxlbSwgSSBiYWNrcG9ydGVkIHRoZSBwYXRjaCB0byA0LjQuIEkKPiBj
b21waWxlIHRlc3RlZCBpdCBvbiBjaXAgdGVzdCBmYXJtLCBidXQgaXQgd2FzIG9ubHkgYnVpbHQg
Zm9yIHNpbmdsZQo+IHRhcmdldCwgcHJvYmFibHkgZHVlIHRvIHRvbyBiaWcgY29uZmlnLgo+Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvbmV0LmMgYi9kcml2ZXJzL3Zob3N0L25ldC5jCj4g
aW5kZXggMTQ1OWRjOWZkNzAxLi41ZWZhYzMzYzI5ZGMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92
aG9zdC9uZXQuYwo+ICsrKyBiL2RyaXZlcnMvdmhvc3QvbmV0LmMKPiBAQCAtODE1LDExICs4MTUs
NyBAQCBzdGF0aWMgaW50IHZob3N0X25ldF9yZWxlYXNlKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0
cnVjdCBmaWxlICpmKQo+ICAKPiAgc3RhdGljIHN0cnVjdCBzb2NrZXQgKmdldF9yYXdfc29ja2V0
KGludCBmZCkKPiAgewo+IC0Jc3RydWN0IHsKPiAtCQlzdHJ1Y3Qgc29ja2FkZHJfbGwgc2E7Cj4g
LQkJY2hhciAgYnVmW01BWF9BRERSX0xFTl07Cj4gLQl9IHVhZGRyOwo+IC0JaW50IHVhZGRyX2xl
biA9IHNpemVvZiB1YWRkciwgcjsKPiArCWludCByOwo+ICAJc3RydWN0IHNvY2tldCAqc29jayA9
IHNvY2tmZF9sb29rdXAoZmQsICZyKTsKPiAgCj4gIAlpZiAoIXNvY2spCj4gQEAgLTgzMSwxMiAr
ODI3LDcgQEAgc3RhdGljIHN0cnVjdCBzb2NrZXQgKmdldF9yYXdfc29ja2V0KGludCBmZCkKPiAg
CQlnb3RvIGVycjsKPiAgCX0KPiAgCj4gLQlyID0gc29jay0+b3BzLT5nZXRuYW1lKHNvY2ssIChz
dHJ1Y3Qgc29ja2FkZHIgKikmdWFkZHIuc2EsCj4gLQkJCSAgICAgICAmdWFkZHJfbGVuLCAwKTsK
PiAtCWlmIChyKQo+IC0JCWdvdG8gZXJyOwo+IC0KPiAtCWlmICh1YWRkci5zYS5zbGxfZmFtaWx5
ICE9IEFGX1BBQ0tFVCkgewo+ICsJaWYgKHNvY2stPnNrLT5za19mYW1pbHkgIT0gQUZfUEFDS0VU
KSB7Cj4gIAkJciA9IC1FUEZOT1NVUFBPUlQ7Cj4gIAkJZ290byBlcnI7Cj4gIAl9Cj4gLS0gCj4g
Mi4yMC4xCgpUaGlzIHBhdGNoIGZhaWxzIHRvIGFwcGx5IHdpdGggdGhlIGZvbGxvd2luZyBlcnJv
ciAtCgogICAgJSBnaXQgYW0gdmhvc3QubWJveAogICAgQXBwbHlpbmc6IHZob3N0OiBDaGVjayBk
b2NrZXQgc2tfZmFtaWx5IGluc3RlYWQgb2YgY2FsbCBnZXRuYW1lCiAgICBlcnJvcjogY29ycnVw
dCBwYXRjaCBhdCBsaW5lIDE2CiAgICBQYXRjaCBmYWlsZWQgYXQgMDAwMSB2aG9zdDogQ2hlY2sg
ZG9ja2V0IHNrX2ZhbWlseSBpbnN0ZWFkIG9mIGNhbGwKICAgIGdldG5hbWUKICAgIGhpbnQ6IFVz
ZSAnZ2l0IGFtIC0tc2hvdy1jdXJyZW50LXBhdGNoJyB0byBzZWUgdGhlIGZhaWxlZCBwYXRjaAog
ICAgV2hlbiB5b3UgaGF2ZSByZXNvbHZlZCB0aGlzIHByb2JsZW0sIHJ1biAiZ2l0IGFtIC0tY29u
dGludWUiLgogICAgSWYgeW91IHByZWZlciB0byBza2lwIHRoaXMgcGF0Y2gsIHJ1biAiZ2l0IGFt
IC0tc2tpcCIgaW5zdGVhZC4KICAgIFRvIHJlc3RvcmUgdGhlIG9yaWdpbmFsIGJyYW5jaCBhbmQg
c3RvcCBwYXRjaGluZywgcnVuICJnaXQgYW0gLS1hYm9ydCIuCgpUaGVyZSBpcyBzb21lIGVuY29k
aW5nIGlzc3VlIGluIHlvdXIgbWFpbCBjbGllbnQuIFRoZSBzYW1lIHdvcmtmbG93CndvcmtzIGZv
ciBvdGhlciBrZXJuZWwgcGF0Y2hlcy4KClRoYW5rcywKUHVuaXQKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KY2lwLWRldiBtYWlsaW5nIGxpc3QKY2lwLWRl
dkBsaXN0cy5jaXAtcHJvamVjdC5vcmcKaHR0cHM6Ly9saXN0cy5jaXAtcHJvamVjdC5vcmcvbWFp
bG1hbi9saXN0aW5mby9jaXAtZGV2Cg==
