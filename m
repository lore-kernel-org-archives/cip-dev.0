Return-Path: <SRS0=d2nN=5C=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED40AC10F29
	for <cip-dev@archiver.kernel.org>; Tue, 17 Mar 2020 08:00:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A432A20674
	for <cip-dev@archiver.kernel.org>; Tue, 17 Mar 2020 08:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bq6B5kti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A432A20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 66A8987303;
	Tue, 17 Mar 2020 08:00:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T119HN7Ik7Zo; Tue, 17 Mar 2020 08:00:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 95F91872F0;
	Tue, 17 Mar 2020 08:00:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DCCEC013E;
	Tue, 17 Mar 2020 08:00:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2BCA0C013E
 for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2020 08:00:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2786687303
 for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2020 08:00:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aQz-46yA8yI2 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2020 08:00:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
 [209.85.222.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 29810872FC
 for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2020 08:00:50 +0000 (UTC)
Received: by mail-qk1-f196.google.com with SMTP id x18so10822545qki.10
 for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2020 01:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LrsFi3+cC6t3Su7aO8m56pUtxuTgxQttyqU9Vb/AAsM=;
 b=Bq6B5ktii08WVnFYuAKD1Br7kOKUgC0hY5MB2/jCfmZTiB+QZLNcL+Pw8VRrMqll2d
 MKNjDBCwEhyw0uszJQT9n1pbYLmRfSxthlfRb0Y8S5538641NJQIHkEfdOEiDiUmoO2y
 KgUULDr2dmVW6gLsADw73IZ3Wu/Kns124SvAWxAF17ZCxK5E1Iv7CVkVCKv3HS+55L+a
 qgxQliWSE9Q0ekiiC678nyaKowcXqF7IZxq6GsZxcLDDonNQ124qBRI1pU3dRMWCQmBk
 TK6iyN5Fe3UVnQjwNI2rbuBPO1CrPYq4eBK2W7XdkJLlKWEqypLULr6R6Z9k6Bmi61RX
 5nVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LrsFi3+cC6t3Su7aO8m56pUtxuTgxQttyqU9Vb/AAsM=;
 b=cTM/e0s1AHrSvrwVYGwtD7U0QNIOAs5v3A0BkrklsNzDcOLOa2tp2ZLcjn9nuJkeqd
 xv6wPufHPFv0v6AJVK2aILObV9Ye2uZa6V8HoMlohF8Elc6gYvb9/ydvsZIrKuk7ThmD
 VTgQYexrXv9QI2LqS3HhY8UHAHtFi/GjVbzH+CVlGNkyl53Q28VDgudEtgSLemO3iRuN
 UaYzHB+Kj98jXNWVYlxK+rB43g018VjAFMs04VoaGXLIULktCYueKfuRFbYKljOtPmL6
 YIVKJjNZL5FTSaoQQIVxkLxXzkZW7TIJCK54JQZ5D+DJbWSiOnrKRSTycqpFTRNW0xrD
 9ogg==
X-Gm-Message-State: ANhLgQ0f07pwjCvDH72kIO4+Jn6zDuTZk+WfGmjv+Rx+hzX1IO6ObVqX
 4fNSH6O4RQIdRKzO/hHEMXCJ/KvMFKnWczWaRFs=
X-Google-Smtp-Source: ADFU+vv7lIhyS7ksBfXTgoC8f/TsZ3sCNXPOPtDKRkiRGM3L1aXYk3FgCQKyNs4C59qRLlZa8D1aVrkQnmJnAsB0PrM=
X-Received: by 2002:a05:620a:1644:: with SMTP id
 c4mr3386033qko.315.1584432048630; 
 Tue, 17 Mar 2020 01:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <CALLGG_Juuz3wktbc71uo68shAU4ZpaxKzAqycKtzKd0R4Meemg@mail.gmail.com>
 <8cc7afeb-409b-3dee-df4b-e6a63f979723@siemens.com>
 <OSAPR01MB36676897A7976E3D6079ECDE92F90@OSAPR01MB3667.jpnprd01.prod.outlook.com>
In-Reply-To: <OSAPR01MB36676897A7976E3D6079ECDE92F90@OSAPR01MB3667.jpnprd01.prod.outlook.com>
From: vijai kumar <vijaikumar.kanagarajan@gmail.com>
Date: Tue, 17 Mar 2020 13:30:29 +0530
Message-ID: <CALLGG_J1dHZqFKLQvUszh35-ZO3d_w7m4SQuAcqSYbyNAQH8LQ@mail.gmail.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] Linux-cip: Kselftest plans
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

T24gVHVlLCBNYXIgMTcsIDIwMjAgYXQgNDoxOSBBTSA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hp
YmEuY28uanA+IHdyb3RlOgo+Cj4gSGkgYWxsLAo+Cj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQo+ID4gRnJvbTogSmFuIEtpc3prYSBbbWFpbHRvOmphbi5raXN6a2FAc2llbWVucy5jb21d
Cj4gPiBTZW50OiBUdWVzZGF5LCBNYXJjaCAxNywgMjAyMCAxMjoyNyBBTQo+ID4gVG86IHZpamFp
IGt1bWFyIDx2aWphaWt1bWFyLmthbmFnYXJhamFuQGdtYWlsLmNvbT47Cj4gPiBjaXAtZGV2QGxp
c3RzLmNpcC1wcm9qZWN0Lm9yZzsgQ2hyaXMgUGF0ZXJzb24KPiA+IDxDaHJpcy5QYXRlcnNvbjJA
cmVuZXNhcy5jb20+OyBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKXi++8s++8t++8
o+KWoQo+ID4g77yv77yz77y0KSA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+OyBQ
YXZlbCBNYWNoZWsKPiA+IDxwYXZlbEBkZW54LmRlPgo+ID4gU3ViamVjdDogUmU6IFtjaXAtZGV2
XSBMaW51eC1jaXA6IEtzZWxmdGVzdCBwbGFucwo+ID4KPiA+IE9uIDA2LjAzLjIwIDA5OjIxLCB2
aWphaSBrdW1hciB3cm90ZToKPiA+ID4gSGkgQWxsLAo+ID4gPgo+ID4gPiBJcyBrc2VsZnRlc3Qg
bWFpbnRhaW5lZCBpbiB0aGUgY2lwLWtlcm5lbCB0cmVlPyBJIGRvIHNlZSBzb21lCj4gPiA+IGJy
YW5jaFsxXSBtYWludGFpbmVkIGJ5IE5vYnVoaXJvLXNhbiBmb3Iga3NlbGZ0ZXN0LCBidXQgaXQn
cyBvdXQgb2YKPiA+ID4gNS42IGxpbnV4IHRyZWUuCj4gPiA+Cj4gPiA+IFRoZSByZWFzb24gYmVp
bmcgdG8gZ2F0aGVyIGNvbGxlY3RpdmUgdGhvdWdodHMgYWJvdXQgdGhlIHBsYW4gZm9yCj4gPiA+
IGtzZWxmdGVzdCBiYXNlZCB0ZXN0cyBmb3IgY2lwIGtlcm5lbC4gQXJlIHRoZXJlIGFueSBleGlz
dGluZyBvciBmdXR1cmUKPiA+ID4gcGxhbnMgZm9yIHVzaW5nIGtzZWxmdGVzdCBmb3IgdGVzdGlu
ZyBjaXAga2VybmVscz8gSWYgc28gYXJlIHdlIGdvaW5nCj4gPiA+IHRvIHVzZSB0aGUgbGF0ZXN0
IHRyZWUgZnJvbSB1cHN0cmVhbSBvciBwbGFuIHRvIGZpeC9iYWNrcG9ydCB0ZXN0Cj4gPiA+IGNh
c2VzIHRvIGN1cnJlbnQgY2lwIGtlcm5lbCB2ZXJzaW9ucz8KPgo+IEkgYW0gbm93IGltcGxlbWVu
dGluZyBMQVZBJ3Mga3NlbGZ0ZXN0LiBUaGlzIGtzZWxmdGVzdCB1c2VzIGtzZWZsZnRlc3QgaW5j
bHVkZWQgaW4gdGhlIGxhdGVzdCBrZXJuZWwuCj4gVGhlcmUgYXJlIG5vIHBsYW5zIHRvIGJhY2tw
b3J0IHRlc3RzIHRvIDQuNCBvciA0LjE5LiBJIGJlbGlldmUgdGhhdCBrc2VmbHRlc3QgaW5jbHVk
ZWQgaW4gdGhlIENJUCBrZXJuZWwKPiBpcyBpbmFkZXF1YXRlIGluIGZ1bmN0aW9uIGFuZCBkaWZm
aWN1bHQgdG8gdXNlIGFzIGl0IGlzLgo+IEkgc3VnZ2VzdCB1c2luZyBhIG5ldyBrZXJuZWwgdGVz
dCB0aGF0IGluY29ycG9yYXRlcyB0aGUgbGF0ZXN0IHRlc3RzLgo+CgpUaGFuayB5b3UgTm9idWhp
cm8tU2FuLiBPdXIgb3JpZ2luYWwgaWRlYSB3YXMgdG8gdXNlIHRoZSBrc2VsZnRlc3QKZnJvbSA0
LjE5LzQuNCBjaXAgdHJlZS4gV2UgZmFjZWQgc29tZSBpc3N1ZXMgd2l0aApvdXQtb2YtdHJlZSBj
b21waWxhdGlvbiB3aGlsZSBkZWJpYW5pemluZyBpdC4gQWxzbyB3ZSBmYWNlZCBzb21lCmNvbXBp
bGF0aW9uIGlzc3Vlcy4KCklmIHRoYXQgaXMgdGhlIGNhc2UsIHRoYXQgd2UgYXJlIGdvaW5nIHRv
IHVzZSBrc2VsZnRlc3QgZnJvbSB0aGUKbGF0ZXN0IGtlcm5lbCwgaG93IGNhbiB3ZSB0cmFjayB0
aGUga3NlbGZ0ZXN0IGJpbmFyaWVzIGZvciBhCnBhcnRpY3VsYXIKY2lwIGtlcm5lbCByZWxlYXNl
PyBJIGFtIG5vdCBzdXJlIGlmIGFsbCB0aGUgdGVzdCBjYXNlcyB3b3VsZCBwYXNzIGZvcgo0LjE5
LzQvNC4gRG8geW91IGhhdmUgYW55IHBsYW5zIHRvIG1haW50YWluIGEgYnJhbmNoIGFuZCByZWxl
YXNlCmtzZWxmdGVzdCBiaW5hcmllcyBhbmQvb3IgdGVzdGNhc2VzIHRoYXQgaGF2ZSBiZWVuIHRl
c3RlZCB3aXRoIGEKcGFydGljdWxhciBjaXAga2VybmVsIHJlbGVhc2U/CgpUaGFua3MsClZpamFp
IEt1bWFyIEsKCj4gQmVzdCByZWdhcmRzLAo+ICAgTm9idWhpcm8KPgo+Cl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmNpcC1kZXYgbWFpbGluZyBsaXN0CmNp
cC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnCmh0dHBzOi8vbGlzdHMuY2lwLXByb2plY3Qub3Jn
L21haWxtYW4vbGlzdGluZm8vY2lwLWRldgo=
