Return-Path: <SRS0=pnUA=EA=lists.cip-project.org=bounce+64572+5673+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF0FC4363A
	for <cip-dev@archiver.kernel.org>; Sun, 25 Oct 2020 22:23:46 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6D39207C3
	for <cip-dev@archiver.kernel.org>; Sun, 25 Oct 2020 22:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="DapLwALf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D39207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5673+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id zT73YY4521723xyDLxJmyoMs; Sun, 25 Oct 2020 15:23:45 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web09.4940.1603664622724146594
 for <cip-dev@lists.cip-project.org>;
 Sun, 25 Oct 2020 15:23:44 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 09PMNFig013786; Mon, 26 Oct 2020 07:23:15 +0900
X-Iguazu-Qid: 2wHHmca9fHryiQQltY
X-Iguazu-QSIG: v=2; s=0; t=1603664595; q=2wHHmca9fHryiQQltY; m=d+P+pvAacCsDddI60e4zgXWjsXVlv+UcwVlqypZEohg=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1110) id 09PMNCel000314;
	Mon, 26 Oct 2020 07:23:13 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 09PMNB6c010530;
	Mon, 26 Oct 2020 07:23:11 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 09PMNBhZ007595;
	Mon, 26 Oct 2020 07:23:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8utB5n8kwD9/hW14ho5/3ewqHXgczG66FA/CYuOeL2z9+tEPjyZySfNbTxw4SaoPx2zECT/zaSvBLeSvlVXgpKWfk2oVpe5DADotcFaOMDFXCMeH7R4Pi4++MBLecO0+2L5hjaEeeWaSKr/+qHwI5dBGjgxzSO4WLoLrkaqZgHNMwaAQJILTOnDxcg794TXOMPdHa8T61ItegN5fPikRVeqckRY1PWA2l2v7qaSbPl99WgMFjaplBTQY9dQs7cKqEsf3E4xYF+djEU2rVcaxpLzQDHnX1nKbpqWlfeh5aQ52P3FrA3nRfPVsSiMrlANMSMenH3r5NOLJLpKX1REZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qoEEqw9VhT5Elz7pNqr4vMVi3Vb3TXssTvW2/cBEVn0=;
 b=F1cYQ5QreUCcPXIHYXPdwhCaLNf/7sxhiM0frRaSfD3/ZaerD6LRqX9SzRnGS7UP+0VETTarB2SusZGglr4U/ut2ilwLKp6yrZOq0EFP5Qybogi8n5im2Ah6d4ImmKJJ2sJnW8y9fXnebzpzyEphhnePxyDuQxgbkTyYD3J440l9GnsMR7VSqkpu8AHOs+drZ72zYfyQchM3UsbKQPl5SQGv7a/pI4dYAyz/qgqaZ3j18LkUmWlegX2bcEuDi5GSMKU3jS7CwgKSNfjzmRsnNIxa7UUlozBlfMvT+oUUrg03sU8FPTL7J3E6l7stagGuJhI6AzLrXxpidmUjztH9ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <masashi.kudo@cybertrust.co.jp>, <ben.hutchings@codethink.co.uk>,
        <pavel@denx.de>, <wens@csie.org>, <Chris.Paterson2@renesas.com>
Subject: [cip-dev] [ANNOUNCE] Release v4.19.152-cip37
Thread-Topic: [ANNOUNCE] Release v4.19.152-cip37
Thread-Index: AdarHPcAa2h04FDgT52A6luuAR4mzQ==
Date: Sun, 25 Oct 2020 22:23:02 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB29832C09252ED68D25BB107F92180@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e947b40-0a47-47b6-492a-08d8793489e3
x-ms-traffictypediagnostic: OSAPR01MB2018:
x-microsoft-antispam-prvs: <OSAPR01MB2018198CD3774CE9758FBF5992180@OSAPR01MB2018.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: i5+STyBC5/bXMYWDYkSnCJn+NtIQd8/U2ECy/P/I/Dq0s96k4/yZHhs2KYRVTBq10+zYQF8xOL4L8eqgWVxKPDxVWzX/eQntvGgF+/RjZTHz6btOXWiZkfthGb8Yi1rLuyVGxix3OVLVpdBnWbZcuWiJFs6IHpu3WnL3T16BbF9m0aM2iR1kWeT34gGjFd+M1v/ugSUVnhxY9TMIRY+/82pINVUq7fsZNKyOUjSV4ujH3MPZZQWnDbHar8fqMbvVt415sbLtFK27HVzl7gi1S/OGsAOhY1Ql4m8CttkJzwQ3E61kLCOQwBC9ttV/8JiPMPPcrQmiMVid2CQHOwmCX7XxdHGfHUzl6xJC66m1lEQ9frftkgc7Q8qv4AaVgSbopNRBKxwqYpWIa1NldFu4mw==
x-ms-exchange-antispam-messagedata: LDoW3BOHJ026Sw3u7ZoLwawlSATQjpAL7C21CsoColSqLBfe4sS6YZetFtAKb51nTkyd48DWEOGncd1Rw+1Fn1/PNDupaR+F3qEMd6m8r2Lr0xJHNEaG80MhYFOZ+fuGrt2MYi2Sk+doWA76sMNj79wDAGJrBhFTiOYOgpUGmV5O45aSex4MbsAJVyzYVXqQG8pGWBxUsJBVwGh53qD3fP5CLBjTu76GZgtPXoZMbNcGP3U9WVPRVKLfBU5oNo+88e/LzaG4ki2pnf1VSAOnmoN+JaCKNCQ4bCzLikR/K8BizvIA18IupKJHjiYrF8XxEYdnRd08r/9fIlFIPIYxpZF+yPlTI3GNoVG71CtVRdhwNrbYT7DEKf71rbBpeaHfqy75FVcBxgLejmWC1w/+v/Ap9dl9CYbqoiRrlIOYfDxmG1F8GFqpTpCivZhfDLnlO51CjOrN8jNTIDLgfwvxrBHAzuRnw9xVS/pibSufpX2gbs1Z6Xmux6kkdfcvFvHeRn1swGW8gMfJVww0KO0NKgnaSWXEqh9fQDI3kxJvbXQLt5RnA13DElALczSCOdjWhQ7hWEKm2xHfnx83VOzLfz/isPPcDWBUTz+OMDeohict7rkyClZMyCLxeeFXJBlIZK+GkM0ddDbZQ8nH1Vt7og==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e947b40-0a47-47b6-492a-08d8793489e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2020 22:23:03.0700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6LChFJYRhHgHOT/8jSz5yIiS+thdLp94VTfVuJZrTwSNOXzXcD5lqmiv/s1Atb2NVjlCd8msWHOdPbh18jo8GCU3cEAwT1f4KOX6C2n+xPrCCkbeEsWVRLaZOPoKom39
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2018
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: nHJ9j2YzCnhvu0ZRpT6jAfrrx4520388AA=
Content-Type: multipart/mixed; boundary="MygOXMOS7BPmGUi3Z8TI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603664625;
 bh=QZy/OKP2moux+JoG5t2pRyw/9RXgljcdgaJV84VtkxA=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=DapLwALf0XNyyGJeWaqh3UpsGMQy+LpsmRM0lkSrkxjd6pRGaY0yQvJYM8xWCUQ3vZm
 UleaTliYbmFq8CK7KQIk1pL5p/Auas+DGTyYLuWagjxYnIpYrShC4fscEhNCkTI/G0AEJ
 o9Scm932ES53jSLQxkx0MKqVwgTyj/kkX6U=

--MygOXMOS7BPmGUi3Z8TI
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCkNJUCBrZXJuZWwgdGVhbSBoYXMgcmVsZWFzZWQgTGludXgga2VybmVsIHY0LjE5LjE1
Mi1jaXAzNy4NClRoZSBsaW51eC00LjE5LnktY2lwIHRyZWUgaGFzIGJlZW4gdXBkYXRlZCBiYXNl
IHZlcnNpb24gZnJvbSB2NC4xOS4xNTANCnRvIHY0LjE5LjE1Mi4gQW5kIHRoaXMgcmVsZWFzZSBh
ZGRzIFBDSS1FIGRyaXZlciBzdXBwb3J0IGZvciBSZW5lc2FzIFJaL0cyLg0KDQpZb3UgY2FuIGdl
dCB0aGlzIHJlbGVhc2UgdmlhIHRoZSBnaXQgdHJlZSBhdDoNCg0KICB2NC4xOS4xNTItY2lwMzc6
DQogICAgcmVwb3NpdG9yeToNCiAgICAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9s
aW51eC9rZXJuZWwvZ2l0L2NpcC9saW51eC1jaXAuZ2l0DQogICAgYnJhbmNoOg0KICAgICAgbGlu
dXgtNC4xOS55LWNpcA0KICAgIGNvbW1pdCBoYXNoOg0KICAgICAgNmRiZjZjMTQ1NDBhOGEzNTU4
NGI0NDE0ZDAyZjNlMDgyOTRjNmMzNg0KICAgIGFkZGVkIGNvbW1pdHM6DQogICAgICBDSVA6IEJ1
bXAgdmVyc2lvbiBzdWZmaXggdG8gLWNpcDM3IGFmdGVyIG1lcmdlIGZyb20gc3RhYmxlDQogICAg
ICBtaXNjOiBwY2lfZW5kcG9pbnRfdGVzdDogQWRkIERldmljZSBJRCBmb3IgUlovRzJFIFBDSWUg
Y29udHJvbGxlcg0KICAgICAgYXJtNjQ6IGRlZmNvbmZpZzogRW5hYmxlIFItQ2FyIFBDSWUgZW5k
cG9pbnQgZHJpdmVyDQogICAgICBQQ0k6IHJjYXI6IEFkZCBlbmRwb2ludCBtb2RlIHN1cHBvcnQN
CiAgICAgIGR0LWJpbmRpbmdzOiBQQ0k6IHJjYXI6IEFkZCBiaW5kaW5ncyBmb3IgUi1DYXIgUENJ
ZSBlbmRwb2ludCBjb250cm9sbGVyDQogICAgICBQQ0k6IHJjYXI6IEZpeCBjYWxjdWxhdGluZyBt
YXNrIGZvciBQQ0lFUEFNUiByZWdpc3Rlcg0KICAgICAgUENJOiByY2FyOiBNb3ZlIHNoYXJlYWJs
ZSBjb2RlIHRvIGEgY29tbW9uIGZpbGUNCiAgICAgIGFybTY0OiBkZWZjb25maWc6IEVuYWJsZSBD
T05GSUdfUENJRV9SQ0FSX0hPU1QNCiAgICAgIFBDSTogcmNhcjogUmVuYW1lIHBjaWUtcmNhci5j
IHRvIHBjaWUtcmNhci1ob3N0LmMNCiAgICAgIFBDSTogZW5kcG9pbnQ6IGZ1bmN0aW9ucy9wY2kt
ZXBmLXRlc3Q6IFByaW50IHRocm91Z2hwdXQgaW5mb3JtYXRpb24NCiAgICAgIFBDSTogZW5kcG9p
bnQ6IEFkZCBzdXBwb3J0IHRvIGhhbmRsZSBtdWx0aXBsZSBiYXNlIGZvciBtYXBwaW5nIG91dGJv
dW5kIG1lbW9yeQ0KICAgICAgUENJOiBlbmRwb2ludDogUGFzcyBwYWdlIHNpemUgYXMgYXJndW1l
bnQgdG8gcGNpX2VwY19tZW1faW5pdCgpDQogICAgICBQQ0k6IGVuZHBvaW50OiBGaXggLT5zZXRf
bXNpeCgpIHRvIHRha2UgQklSIGFuZCBvZmZzZXQgYXMgYXJndW1lbnRzDQogICAgICBQQ0k6IHBj
aS1lcGYtdGVzdDogQWRkIHN1cHBvcnQgdG8gZGVmZXIgY29yZSBpbml0aWFsaXphdGlvbg0KICAg
ICAgUENJOiBlbmRwb2ludDogQWRkIG5vdGlmaWNhdGlvbiBmb3IgY29yZSBpbml0IGNvbXBsZXRp
b24NCiAgICAgIFBDSTogZW5kcG9pbnQ6IEFkZCBjb3JlIGluaXQgbm90aWZ5aW5nIGZlYXR1cmUN
CiAgICAgIFBDSTogZW5kcG9pbnQ6IEFzc2lnbiBmdW5jdGlvbiBudW1iZXIgZm9yIGVhY2ggUEYg
aW4gRVBDIGNvcmUNCiAgICAgIFBDSTogZW5kcG9pbnQ6IFByb3RlY3QgY29uY3VycmVudCBhY2Nl
c3MgdG8gcGNpX2VwZl9vcHMgd2l0aCBtdXRleA0KICAgICAgUENJOiBlbmRwb2ludDogUmVwbGFj
ZSBzcGlubG9jayB3aXRoIG11dGV4DQogICAgICBQQ0k6IGVuZHBvaW50OiBVc2Ugbm90aWZpY2F0
aW9uIGNoYWluIG1lY2hhbmlzbSB0byBub3RpZnkgRVBDIGV2ZW50cyB0byBFUEYNCiAgICAgIHRv
b2xzOiBQQ0k6IEZpeCBmZCBsZWFrYWdlDQogICAgICB0b29sczogUENJOiBFeGl0IHdpdGggZXJy
b3IgY29kZSB3aGVuIHRlc3QgZmFpbHMNCiAgICAgIFBDSTogZHdjOiBGaXggZHdfcGNpZV9lcF9y
YWlzZV9tc2l4X2lycSgpIHRvIGdldCBjb3JyZWN0IE1TSS1YIHRhYmxlIGFkZHJlc3MNCiAgICAg
IFBDSTogZW5kcG9pbnQ6IEZpeCBjbGVhcmluZyBzdGFydCBlbnRyeSBpbiBjb25maWdmcw0KICAg
ICAgUENJOiBlbmRwb2ludDogQ2FzdCB0aGUgcGFnZSBudW1iZXIgdG8gcGh5c19hZGRyX3QNCiAg
ICAgIFBDSTogZW5kcG9pbnQ6IENsZWFyIEJBUiBiZWZvcmUgZnJlZWluZyBpdHMgc3BhY2UNCiAg
ICAgIFBDSTogZW5kcG9pbnQ6IFNraXAgb2RkIEJBUiB3aGVuIHNraXBwaW5nIDY0Yml0IEJBUg0K
ICAgICAgUENJOiBlbmRwb2ludDogQWxsb2NhdGUgZW5vdWdoIHNwYWNlIGZvciBmaXhlZCBzaXpl
IEJBUg0KICAgICAgUENJOiBlbmRwb2ludDogU2V0IGVuZHBvaW50IGNvbnRyb2xsZXIgcG9pbnRl
ciB0byBOVUxMDQogICAgICBQQ0k6IGVuZHBvaW50OiBBZGQgc3VwcG9ydCB0byBzcGVjaWZ5IGFs
aWdubWVudCBmb3IgYnVmZmVycyBhbGxvY2F0ZWQgdG8gQkFScw0KICAgICAgUENJOiBlbmRwb2lu
dDogRml4IGEgcG90ZW50aWFsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZQ0KICAgICAgUENJOiBl
bmRwb2ludDogUmVtb3ZlIGZlYXR1cmVzIG1lbWJlciBpbiBzdHJ1Y3QgcGNpX2VwYw0KICAgICAg
UENJOiBkZXNpZ253YXJlLXBsYXQ6IFJlbW92ZSBzZXR0aW5nIGVwYy0+ZmVhdHVyZXMgaW4gRGVz
aWdud2FyZSBwbGF0IEVQIGRyaXZlcg0KICAgICAgUENJOiByb2NrY2hpcDogUmVtb3ZlIHBjaV9l
cGZfbGlua3VwKCkgZnJvbSBSb2NrY2hpcCBFUCBkcml2ZXINCiAgICAgIFBDSTogY2FkZW5jZTog
UmVtb3ZlIHBjaV9lcGZfbGlua3VwKCkgZnJvbSBDYWRlbmNlIEVQIGRyaXZlcg0KICAgICAgUENJ
OiBwY2ktZXBmLXRlc3Q6IFVzZSBwY2lfZXBjX2dldF9mZWF0dXJlcygpIHRvIGdldCBFUEMgZmVh
dHVyZXMNCiAgICAgIFBDSTogcGNpLWVwZi10ZXN0OiBEbyBub3QgYWxsb2NhdGUgbmV4dCBCQVJz
IG1lbW9yeSBpZiBjdXJyZW50IEJBUiBpcyA2NEJpdA0KICAgICAgUENJOiBwY2ktZXBmLXRlc3Q6
IFJlbW92ZSBzZXR0aW5nIGVwZl9iYXIgZmxhZ3MgaW4gZnVuY3Rpb24gZHJpdmVyDQogICAgICBQ
Q0k6IGVuZHBvaW50OiBGaXggcGNpX2VwZl9hbGxvY19zcGFjZSgpIHRvIHNldCBjb3JyZWN0IE1F
TSBUWVBFIGZsYWdzDQogICAgICBQQ0k6IGVuZHBvaW50OiBBZGQgaGVscGVyIHRvIGdldCBmaXJz
dCB1bnJlc2VydmVkIEJBUg0KICAgICAgUENJOiBjYWRlbmNlOiBQb3B1bGF0ZSAtPmdldF9mZWF0
dXJlcygpIGNkbnNfcGNpZV9lcGNfb3BzDQogICAgICBQQ0k6IHJvY2tjaGlwOiBQb3B1bGF0ZSAt
PmdldF9mZWF0dXJlcygpIGR3X3BjaWVfZXBfb3BzDQogICAgICBQQ0k6IHBjaS1kcmE3eHg6IFBv
cHVsYXRlIC0+Z2V0X2ZlYXR1cmVzKCkgZHdfcGNpZV9lcF9vcHMNCiAgICAgIFBDSTogZGVzaWdu
d2FyZS1wbGF0OiBQb3B1bGF0ZSAtPmdldF9mZWF0dXJlcygpIGR3X3BjaWVfZXBfb3BzDQogICAg
ICBQQ0k6IGR3YzogQWRkIC0+Z2V0X2ZlYXR1cmVzKCkgY2FsbGJhY2sgZnVuY3Rpb24gdG8gZHdf
cGNpZV9lcF9vcHMNCiAgICAgIFBDSTogZW5kcG9pbnQ6IEFkZCBuZXcgcGNpX2VwY19vcHMgdG8g
Z2V0IEVQQyBmZWF0dXJlcw0KDQpCZXN0IHJlZ2FyZHMsDQogICBOb2J1aGlybw0K

--MygOXMOS7BPmGUi3Z8TI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5673): https://lists.cip-project.org/g/cip-dev/message=
/5673
Mute This Topic: https://lists.cip-project.org/mt/77802326/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--MygOXMOS7BPmGUi3Z8TI--
