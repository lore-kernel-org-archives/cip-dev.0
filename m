Return-Path: <SRS0=fe5i=KM=lists.cip-project.org=bounce+64572+6461+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94B4C433B4
	for <cip-dev@archiver.kernel.org>; Mon, 17 May 2021 05:27:40 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 396056101B
	for <cip-dev@archiver.kernel.org>; Mon, 17 May 2021 05:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 396056101B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6461+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 7zd0YY4521723xMpCdZMpmxx; Sun, 16 May 2021 22:27:39 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.14996.1621229257268321968
 for <cip-dev@lists.cip-project.org>;
 Sun, 16 May 2021 22:27:39 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 14H5RND4029203; Mon, 17 May 2021 14:27:23 +0900
X-Iguazu-Qid: 2wGqsZ5qwQNr8RGalY
X-Iguazu-QSIG: v=2; s=0; t=1621229243; q=2wGqsZ5qwQNr8RGalY; m=HeLjhKsqxKMvm0a4jwd/BTZgvQvhJG1yH+Go6bj0Z6o=
X-Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1112) id 14H5RLgf015289
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 17 May 2021 14:27:22 +0900
X-Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id E04DB10008F;
	Mon, 17 May 2021 14:27:21 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 14H5RJLM011901;
	Mon, 17 May 2021 14:27:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZnXS4ub6FQdoZpzw2JX/RjX1nDT2THBe2CpdQJFl5VqodDWLAx8HKjmvFB8AYmHMnlAty6OFB/+6TpcQOHLCs1WM6TXKOYhG6NF+MYD6HHyuhg2usplbN0WJUc/8CSaoy2PPmL/Q9pq6OjVTvxcB8zzaDI8Ptv8yLqI74DuwF30GtRafAnPe4Hl2JA0BNxg50buUU+EhGCrs0EhJNip6ylT+29ket/X0SfKJzoD+UqswT0Nl6Gyy8w2yxml/47UDD2M8YHjvncIxYERuAcr3rgytIR8rt6uXXZby9jH4crzLuJDjil9bS2547UVm5ZIo9DLPV5DYxSTI5CfHSK8cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVklq7NaoyLUM0GW5QwYlCsWnR2Jo4y5Hp0OTYUHsQA=;
 b=OhQClur/PJRHUqgF3VdS2LHVvSM+1kVz9U0Kz8Aydnp/FcDtP7m9pSifeDMmN9mTL1cpZ4cyyH/O3pRK2gCUvDjs3t2POAzTmxSw73R0ufYtLwDoyro0UIk6qVb0S78qePmhM4rByTvg9+GnYLgEeIN29QfH/nfBHHhUKXdrm7LIUfa1FQncfrrB05vw83K7lb8LMDLwBbfH1TYmt5z9n3KYzvEPW4QbZhdwO8LfHRs1lvhYaDbX89FOxOBAqu+a2j0APl/jM8w+t6jaY1yZD2rHqz5XIsbLe6LwNcdi1K9YHqEXzGbF+fxQMbWeF/pDOuCpFtpfICBcFhh5yA066A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <wens@csie.org>, <chris.paterson2@renesas.com>,
        <masashi.kudo@cybertrust.co.jp>
Subject: [cip-dev] [ANNOUNCE] Release v4.19.190-cip49 and v4.4.268-cip57
Thread-Topic: [ANNOUNCE] Release v4.19.190-cip49 and v4.4.268-cip57
Thread-Index: AddK3SH4IYyo2jb/TGGUSCtHPDaRAQ==
Date: Mon, 17 May 2021 05:27:18 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB6252CF6E76916FC34C01945D922D9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bdbbdf2-737f-4e55-2244-08d918f47037
x-ms-traffictypediagnostic: TY2PR01MB3241:
x-microsoft-antispam-prvs: <TY2PR01MB32418CF292ED446B8BE1B8E9922D9@TY2PR01MB3241.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:660;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +G1cvjXJvUEi5djXpxqHh3XqPwjN4AWgkMA3DaUG6RjSViQOn1amyakusxF1NxfOTkzDlftJsiE18EqOdlruJAWxQnEjDFK8aCaLzem9kPZ0ctLRkr4Na6I2qcCezgT2ttpjwmQYjxsvZZ/N3vJJyqeVu5iwRDKmCfXX0gG80kg4i4h+/fQvj3oNpBesgW9CnCQLR8bnC3UXUdAoPqd3nA9vLuIx05l06Co0PvdG0Xm9c37QGqYlqfWeyXGLDAGepoARPtEvub6HU30NNkqaIy19RBYH/pvy6e68Vixtk9YYLL+C6rRy18YIECVWlUj/pK+dWOERTu/nNljvwcrLxFR/KpSSrY8FgCEziWaFHh77pQuhSpssKGnn6P6jxz0aYgioK1Xwwo0Cox28of7OjsoU3to6ZCmKNnt09Dq8nVP4TiYIz0U+48DWXm88T0diqN/heGbHLN0Yi44pAEKG7B4DvmYyTM7AflBr90GNr/3EZfEbg1oTap9C78w189Vi/AFnwvyRPHni4cVOdA3IEHbfpwwQi2xV3hbilaPhSPRCMkYQ5o+6R4ugBn6/gALAQKfhbVBSOI1IQgQzqROjTOsqd6my27uTA0ZWEnrhGbjoaOnVcaB7YrTomsY5RbcV8krOK5/lAKaU96R2Oui5Pj+Mr6ao/H9V11Hq46kG/dkCp/p0nD5QAmaKjmvH1HC0
x-ms-exchange-antispam-messagedata: =?utf-8?B?R09KemExRitNd29OL21xYmRpa0hWZ211MFV4WW9EZDhURmJUWXlVZ2I3RE1W?=
 =?utf-8?B?TWljV0pVbWJvVTdpd2Z1M3VXZGNUU1RZeFhYN0dWUk1GaUwwRk52VTRsNnRU?=
 =?utf-8?B?K1NFTGVEL0MrY2FzSUE2T1pEVkFKcXJyNUJ1L2F2bVhISEFyTHBjREhPOXVy?=
 =?utf-8?B?a2lYb1BZemZLd1BUVmxZbHVUNlp3QnZiaEhoQ01mRVE5dENHdmN2c29IMkt3?=
 =?utf-8?B?MnkrcGE5M0hMRTFsbXh6eWs0c0NQM1pNM1dJZWhMNmdOTGV0M1ZmRW9MZHc2?=
 =?utf-8?B?MFE4MmcwV3hyNTJqdlBuVkFxc1E4aURzOEQ0UWhpOEh3STBDdmxwbko3cnZF?=
 =?utf-8?B?bVhqU2F2VkROTC95d0QwcFpFeDFCdm9ucHkrZndaYTF3a0hkWG5QU1lqbGM5?=
 =?utf-8?B?VWZ5ekdMM2FGZUJpVWxXVFRTbUFZY3ptV2VMbld1ejl5eE93WXhWUlA1NUtJ?=
 =?utf-8?B?ZzdaQkE3RXF5RWxMSGtxakxuS3h5ZndLTVBiT3E2bVQ0RDQ2di8vMnhNK3FN?=
 =?utf-8?B?ajRpeCtKMEpHYkVCckVTc1hDUFM1UW55U3puRGJtRmM2K3M1S3h2U0o3b3Vt?=
 =?utf-8?B?SEFUU0ttdWpjdTZUT3Z4RCsxaUNTUlhOOWRlOS9hLzV2dWt4RE13UWtBSmt6?=
 =?utf-8?B?SWRFYkNuL0Q0dCtZOW45eFZPQ0F0Vk5XbTNnSENrYmFVbnlGTXM2dzM1QzB3?=
 =?utf-8?B?WG8zZk8yT0d4N1VCdkk4aXJxRFdDTVZ2TnhXbGNzWUtmQmdCMHBMK1RwUEpa?=
 =?utf-8?B?YmlqWDlIWks4b1VxSEYrWDRWbWsxT0UrQUpKN0lleENlZWlHaWlvcExXUHBr?=
 =?utf-8?B?TnJZa29YeXFhOUVBSVoyQ1FPek92bFB4REluekNhQktkeXVUMEFGakdaL1FP?=
 =?utf-8?B?TTcrcS9nblkvTnJRSTNHN2FibUE4UGozN3UrYWdPUytuc1BMZEtnZzZSNFhF?=
 =?utf-8?B?V3hrRnhIRHY1TDhTMFNwbnA0THVKSHdyMjQyY0VqK2o5UG1hVHRxNFZxNTVo?=
 =?utf-8?B?Uk44NlR1bUlEUmNJZ2MydG5uN3I3TXFOUmxGNEtpdFA5NjRKY0FVQmRvZENH?=
 =?utf-8?B?d1l0SkhpcldaYnVjc2FBRlpMbS9tU3N6VEdjcjJleFdqdFFLbVR2QXdvd21T?=
 =?utf-8?B?T0h6VnpkdDJvUkVGK1R5OUhpMGZiM1VYbnBwbU5HWjVhVmc2Sm9WdDFIZWdo?=
 =?utf-8?B?Rm5JZGRreUFKZC9qV21FbmkzZ3M0cjdjZ2p1cVMvTHJqelhFeCtReXJ4NnFN?=
 =?utf-8?B?OXVvREJWSFRHTnhxTy92RjNKSE5lZVZGSkZ6d3h4K3VsUjlLUER6SGQ3RCtS?=
 =?utf-8?B?cVNyYjB2VnFsQzBzbk56TzNlbFdWMmdjTmdsRW1lMXpwRVY4S2lraE9JNzh3?=
 =?utf-8?B?L3ZSdWlldXg1eUhJdWZwV1hQUE1YWC9ITzA0M1pWQU1sTG1JYXYyNG82OTFB?=
 =?utf-8?B?UG0xaDlMK3pQcVZ3OE1acXpXS1hXTytuU3NsN1VwZXo2b3lEZVRpVnhzcFlp?=
 =?utf-8?B?cENncThIVEhDclNxK1VkU0xma1VwMTh1dkV3SGxqUnBsdVl3a1RZdXcyNUhm?=
 =?utf-8?B?ODNPY3FrZmRIWGdVZVlBZkVJaW9FSGRWOFp5cWN1VGdqWFRNc3dkbjlUaTRp?=
 =?utf-8?B?RkZqanM4LzhLaTFra0NkY2tJM3VJd1lINTFYRjRvdlpIWFhMTUlCRWE5TXRp?=
 =?utf-8?B?S0V1NWxYSjNxQnUxUGt6YlBXSjI0ZjZSMnBBT1gyR1VhZ1Y5Q1NjcjM0Nk1a?=
 =?utf-8?Q?Zm/ybazQRL080PfSKU=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bdbbdf2-737f-4e55-2244-08d918f47037
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2021 05:27:18.2866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ypTP5QBMIlSvveYf6MCQK/Ne6Gd+G6KmwVy9KOYzCIJHMk7ZmYTuN05IrioxHvQYnTqUyQMToTDbtQnbOoelJNCRjNkNsjdcTU9jRboBZ/xlmljWLylHQQvG133HqXu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3241
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: uXcp1zXAbblYJ0DMQHB8dxHfx4520388AA=
Content-Type: multipart/mixed; boundary="ISq7wCEVDmSr9UAaIyoB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1621229259;
 bh=2v9nRLJxRmweU9t2JOBnueNUTW6ndk4X9StFYlw9xUg=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=Q/30fM907qGzIu4qmJG3wfqswgcphCO+CYVNl7zLPhzdpnX50zQ+EfvjXeeNDxMjVfC
 mkW69t82CuTq10VQxNJw7JceJhTWAiAKIxU4L5PWsLLTIiZx3IS6js+95WskuL0ck0D+r
 Kyn0P4Ns2d5VvnjGvbxrmiEmKQs9E0+bfvA=

--ISq7wCEVDmSr9UAaIyoB
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCkNJUCBrZXJuZWwgdGVhbSBoYXMgcmVsZWFzZWQgTGludXgga2VybmVsIHY0LjE5LjE5
MC1jaXA0OSBhbmQgdjQuNC4yNjgtY2lwNTcuDQpUaGUgbGludXgtNC4xOS55LWNpcCB0cmVlIGhh
cyBiZWVuIHVwZGF0ZWQgYmFzZSB2ZXJzaW9uIGZyb20gdjQuMTkuMTg4IHRvIHY0LjE5LjE5MCwN
CmFuZCB0aGUgbGludXgtNC40LnktY2lwIHRyZWUgaGFzIGJlZW4gdXBkYXRlZCBiYXNlIHZlcnNp
b24gZnJvbSB2NC40LjI2NiB0byB2NC40LjI2OC4NCg0KQW5kIHRoZSBsaW51eC00LjE5LnktY2lw
IGhhcyBiZWVuIGFkZGVkIHBhdGNoZXMgdGhhdCBmaXhlcyBpc3N1ZSBvZiBpbXgyMTkuDQoNCllv
dSBjYW4gZ2V0IHRoaXMgcmVsZWFzZSB2aWEgdGhlIGdpdCB0cmVlIGF0Og0KDQogIHY0LjE5LjE5
MC1jaXA0OToNCiAgICByZXBvc2l0b3J5Og0KICAgICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvY2lwL2xpbnV4LWNpcC5naXQNCiAgICBicmFuY2g6DQog
ICAgICBsaW51eC00LjE5LnktY2lwDQogICAgY29tbWl0IGhhc2g6DQogICAgICA3MWU2NjJmNDMw
OTI4MzhjYjgwOWZhYzhiNTM3YjM1ZTQ4NDMxMGJmDQogICAgYWRkZWQgY29tbWl0czoNCiAgICAg
IENJUDogQnVtcCB2ZXJzaW9uIHN1ZmZpeCB0byAtY2lwNDkgYWZ0ZXIgbWVyZ2UgZnJvbSBzdGFi
bGUNCiAgICAgIG1lZGlhOiBpMmM6IGlteDIxOTogQmFsYW5jZSBydW50aW1lIFBNIHVzZS1jb3Vu
dA0KICAgICAgbWVkaWE6IGkyYzogaW14MjE5OiBNb3ZlIG91dCBsb2NraW5nL3VubG9ja2luZyBv
ZiB2ZmxpcCBhbmQgaGZsaXAgY29udHJvbHMgZnJvbSBpbXgyMTlfc2V0X3N0cmVhbQ0KDQogIHY0
LjQuMjY4LWNpcDU3Og0KICAgIHJlcG9zaXRvcnk6DQogICAgICBodHRwczovL2dpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9jaXAvbGludXgtY2lwLmdpdA0KICAgIGJyYW5j
aDoNCiAgICAgIGxpbnV4LTQuNC55LWNpcA0KICAgIGNvbW1pdCBoYXNoOg0KICAgICAgOTk5Yjc0
NDQzY2EzNTZkYWEzYjAyMzhkN2ZmNjc2ZjE5NzI4YWJlZA0KICAgIGFkZGVkIGNvbW1pdHM6DQog
ICAgICBDSVA6IEJ1bXAgdmVyc2lvbiBzdWZmaXggdG8gLWNpcDU3IGFmdGVyIG1lcmdlIGZyb20g
c3RhYmxlDQoNCkJlc3QgcmVnYXJkcywNCiAgIE5vYnVoaXJvDQo=

--ISq7wCEVDmSr9UAaIyoB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6461): https://lists.cip-project.org/g/cip-dev/message=
/6461
Mute This Topic: https://lists.cip-project.org/mt/82880141/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ISq7wCEVDmSr9UAaIyoB--
