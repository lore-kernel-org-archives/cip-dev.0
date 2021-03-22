Return-Path: <SRS0=96MM=IU=lists.cip-project.org=bounce+64572+6305+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9542C433C1
	for <cip-dev@archiver.kernel.org>; Mon, 22 Mar 2021 06:00:17 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40EA661927
	for <cip-dev@archiver.kernel.org>; Mon, 22 Mar 2021 06:00:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40EA661927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6305+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 5Nx3YY4521723xavv62HVJnO; Sun, 21 Mar 2021 23:00:16 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web10.9110.1616392814862190968
 for <cip-dev@lists.cip-project.org>;
 Sun, 21 Mar 2021 23:00:16 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 12M5xnmu031811; Mon, 22 Mar 2021 14:59:49 +0900
X-Iguazu-Qid: 34tKsSMCiEw3JxaPye
X-Iguazu-QSIG: v=2; s=0; t=1616392789; q=34tKsSMCiEw3JxaPye; m=jkoLdi4JGZEEBKR6wNV1oCdjk6eEobsrFJBsJdfhVBU=
X-Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1511) id 12M5xlSj023323
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 22 Mar 2021 14:59:48 +0900
X-Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 5C8C71000B3;
	Mon, 22 Mar 2021 14:59:47 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 12M5xj8k002806;
	Mon, 22 Mar 2021 14:59:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BszkreAQ9EvmD5vVGwVJayk7weRtozk0ws5u6REySaCg/zC3jMY4+LcA/qik7CaZvbuwJ1wuKjx+gFRNn4atp/WzMUo64sumuE3liFJV/UwB96nbw+/56zhpM9NR2V752L5NfrJTCI2fy34RJUEFSNzvL1pCQJqVo1dZedHYWDo+Kd6eUXozykmG06OnGnwBzWUxXYm2UO3ZcWk3TknjeJu1O6Lja4JSsjusQcn0r6YNLtLKxfeJiCkyjKAqbCpExMekjcOx8LNQomu/db3fsXin4M2VMuaodW6/KDLMHPr3rHyifLq+p1UesgJw0NRqic16XLmQp3+Xrewxfhjy6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bo0r88uKHPfsdkj9DtJFisGS5Zj0YDPAp1ywQXiBXrg=;
 b=LeIryvmCLTFrXVxHWC9hFffx3KMfTZ2XGPFTJ8iLD4WfQTaBuah0/sTpnn6MZMUjo1t8xkkevVAJUDa67/ZRh6fcwzHxxFnYdHeHy+xLKa6xhhVpsBPysgc4guxqYF2nXEdmLMGutdCSnzNSgreDQ/kGNI1+6fCwC6IZrkIWUwZNSkzg3sZLSLGJ7rNJ64A3+qVFnllHRVXLFt8jdC/N3EYgPLAUDd3uDG7dgf/kBVSsf21tHtUHIoAiA9Y8lOZHsHaRPDyWAzw0qzN/QYf/6rnYKBw4P1Xx7Bhk/oEAxVwTLslAUNhs+ydLC1eR0Nqoyx99CI+wbUpNhmKXiHZPHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <wens@csie.org>, <masashi.kudo@cybertrust.co.jp>,
        <sudip.mukherjee@codethink.co.uk>
Subject: [cip-dev] [ANNOUNCE] Release v4.19.182-cip45 and v4.4.262-cip55
Thread-Topic: [ANNOUNCE] Release v4.19.182-cip45 and v4.4.262-cip55
Thread-Index: Adce4GDLnUM+MEHGRkqRXIT8LJA6iw==
Date: Mon, 22 Mar 2021 05:59:44 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983575427DC465EBE84F18B92659@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbf61e01-4bfb-4068-4d1a-08d8ecf7b0dd
x-ms-traffictypediagnostic: OSBPR01MB3430:
x-microsoft-antispam-prvs: <OSBPR01MB34305A279CFF77DC63FFBDF992659@OSBPR01MB3430.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:393;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: H5TZ7MUINAhoD+zgGb/eMtMEoT5cxfYvEQ5P1vyvO2Dxe5MIvyakv+Fao0A4Rr+SsEAjfa2Tc0HNqr1BFijlKC1AGbWA9xkWbGfLu1/ewsbUh9sz69Sg8Y1oYEADUDMR7djjA0ceguxYJeIc81bmKRLd0st2ehoptdgxzYjdCNfNLjIGMq7nhbqsygIBCkhhMGWamMov3ZUVfSc2tMDzzmK2GDJWit/TaT9xlkF3vUUx5XwYxTvOdpPasi76xIJHCqr3JIFslzuZxKTthSkT+2gHTJJ79gQKmDmrNvE3fXUJYl44DHuOQXOiJ54sPIY22L7+RpnBpgWnHrMNX4LkImP90paw1UNN7j9DZMTEJ3gn56Cw3gXP6eCCnGELnd56Gh42aTFVM2vCFby9OzJlD17RtC4hosihLW9hscRnvRj4rB6dIwV5m2U0jCD0WYKvxeSLoMA5in7CfPLrj5uoV1m/C+3UTLOH6056Y3AJK4O0OIgyTRX8KgBJYPS5xhruIrOPwWMKbzrLm0oBx5ebKhE7qep5htV0OU7b+o2JzdyhoLNXEjjGbBaCTVQz16UXzdMSIFjVLd20giEnccyto9T7tu03gtKjVmjJU5eeCbFUj5Jz773ryMOFgnydp12ck39hlF4unQYLsH2elfsgbEW8zR8HCqpvrt5DxyjQnwg6dcqukUJQfvfBO3i6sYoRPs2XFS+rMoznW8KIyledwUAcwV6SyHMwcjM7bzdQ3Qs=
x-ms-exchange-antispam-messagedata: =?utf-8?B?MnRQRGVJQ2IrLzJwcWJrL01SckZNZHZKeUNyQW1qSVdxMTNWdldvZ0g4WnNH?=
 =?utf-8?B?VWR6VXRHMG9tRVpCUXFBcnBhUnoxRE1aYittNU11Zi93dmZkVnNtem1xdjlv?=
 =?utf-8?B?ZUdYTFp3MzJjOFBmUjZZYlkwSzd2VHh3Q1h5WEwvd2dsQVBXNFh0S0t6c2pr?=
 =?utf-8?B?NHhpazlLQzlxd1ZhZEllQUdNbURrQmhNT3RnY1MvUzY2aWdScDdWWGptNTRZ?=
 =?utf-8?B?YzdWd3RSSXFuTWpqU3RNTFY3cEZMM2haMXo3VWZhTVJQODRBUURHRG44K1Nr?=
 =?utf-8?B?dGI4b2VvUXhLcHRTckhWMUhVT2twTGUwZjRqQWlLWFRQYW1QNUQwR3p3OUtT?=
 =?utf-8?B?Z1psZUdJWmlHVVFhL2ppdUFZaGZpMnlvRVBkU0VpbFhtZEdqL2RnODJxQkt0?=
 =?utf-8?B?ZmhxSUtSQTZNcE9DWmdZWFRicnJ2bmZqVGp2RnUxMWxMU09KZEpZMXdkcDBm?=
 =?utf-8?B?VzAzcjRNak9XV0RyYjZscGljSGp5bWpiaE1HZy9QbXdDd09zaktqRUV4QWY5?=
 =?utf-8?B?VlMwVHRtY2toWDl2dER5bjBRL2dXUEZJdFdMOThmTGh6Ukw5YnJxZE43N2tu?=
 =?utf-8?B?OU8wVHBvaFdCSGNGU2svQ2tlc3pXbnRRTmNLWFlRVEozeW1sQklNOVZKTkov?=
 =?utf-8?B?OGc1Z0JXTW5YTTZXUjlGMUVsQmFPZnVrYkh1dzc0YTMxQXhOYjNmL3dmS0F6?=
 =?utf-8?B?M0haeE4rZ1haVHQwbTRNTUFsd2JVblBBTnZ2NFFpVmg1WDdvMGVIUm5UV1ZI?=
 =?utf-8?B?KzR1c1Z6dzdOV1Rld21aQVlOdDBjR2xSOFR6S1hFNUpWSVp5ZlZpZzVDSkVR?=
 =?utf-8?B?MzVWbnJ6Z0gvMGE4bnEvREdaVk1XVVQrV1J5Vm1iU2ErUkhOaGFXazJJVExG?=
 =?utf-8?B?QXcxRFZ0WnRzNm1LaDY1OEpjZldSTXM0RFFSQzBYeXN0NUdxVDg2eFpsN0gx?=
 =?utf-8?B?bWpJVnl2MlhBbHJGSnFYVW9CWWZsZ1VDTm53cm9ndmhPTkdBT25zdnF2em1m?=
 =?utf-8?B?MXNNMG1VYnJzVzZJNW0zeW5KVU9EemRRbDl6Si8wMU5iMExIWGlldGlaTlQv?=
 =?utf-8?B?NVV3TXhGbVRiL0hTVkFMNk9ZdGsyd2xjRWpCdXFESk4zVWNoK0ttU1hLcUph?=
 =?utf-8?B?K0dpQmJ6Zkg4SVJ2U0RqVzduY0U2V3oxdVA2cGFhTkg1OC9ER3h0TEFVMFly?=
 =?utf-8?B?Vnl1d2JTbGdOQWVtbUtnckJ5MGlhaDEzVFR1cFZWVWRFQS95VjFiY1Rnc0hm?=
 =?utf-8?B?OXdPbWZJRUgxOW50c0RLbmlKemZnenJSckhsZk14ZmVRcHQzZk9NaWZpRmpS?=
 =?utf-8?B?MUZCTmd2YlVBRkNOQ1oyR0tWSVAxZkJQWVl4MTNsUnBqR0wzSGpvanBqa1Iv?=
 =?utf-8?B?djNwa0h4T1pwV09HcVpNRTJ6RUZiRkdHT0RlT09zZ3V0dGFuV3JzU0dJU0JE?=
 =?utf-8?B?dmNud3BGTVArQ2NWWTlSMWxkeE04VnVaMUhaM2lFV1BHWGIrWktCUVhFTHlX?=
 =?utf-8?B?bG1PcU1OZitjOTdyL2xKVkJqbFZDZ3FMZkVLNW1sQ3lWQk40K3RkbDloVlho?=
 =?utf-8?B?UzVCcmJjVVE5dVJFTGZTR01KQnBRTDU4Z1NpSzBJNFJ5SktDcU92bzJ2akVw?=
 =?utf-8?B?L09BL3k1RmwrY2t1VFlheitINWNSZGFZMzllMi9qMzF1cC9XRlcwc2cvV3ZQ?=
 =?utf-8?B?d25VdERzbzJ6ZU1GL0p4VjVnRnB0U3VCaTNuUjlEM0FMN3BIa052eTkyczVN?=
 =?utf-8?Q?mX9KnMI+Y0NM/B5uYg=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf61e01-4bfb-4068-4d1a-08d8ecf7b0dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 05:59:44.0825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qb1y1FuPO+7N7f41XcWtxEBVRsfXNBETK0TvfgYSMEBRSMijUFYm/yImxLgbITLNMgTZUewI0nsy/B8fvgrL9+uasr95ij8ip0rWtGfkXZetn61SLWea5vsnyd6CcN5P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3430
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: uK9Tbjnlv36G2mgCZ81MY3ogx4520388AA=
Content-Type: multipart/mixed; boundary="DeVyoh3pn3T18DvuOyZJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1616392816;
 bh=TClA/goSe9JsctiLlxJNFLUecB9sYdJWqBjHE8SSq8I=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=G2nuxPhtW3kh3DGSByQmHxcRut9bFygm6Wd9QcdaEVJnJF/PEhR/nx+rvWwhOZJITSU
 v5Ya/ozwY2Xd8aWuupYSPX5R60wcHMjGk4MSaQDB6mWj6eB8qjnGsdny84YZqcIRtSFv2
 CA5NdWbwh46k96HgHXK1XfMzpK1sio467l4=

--DeVyoh3pn3T18DvuOyZJ
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCkNJUCBrZXJuZWwgdGVhbSBoYXMgcmVsZWFzZWQgTGludXgga2VybmVsIHY0LjE5LjE4
Mi1jaXA0NSBhbmQgdjQuNC4yNjItY2lwNTUuDQpUaGUgbGludXgtNC4xOS55LWNpcCB0cmVlIGhh
cyBiZWVuIHVwZGF0ZWQgYmFzZSB2ZXJzaW9uIGZyb20gdjQuMTkuMTc3DQp0byB2NC4xOS4xODIs
IGFuZCBUaGUgbGludXgtNC40LnktY2lwIHRyZWUgaGFzIGJlZW4gdXBkYXRlZCBiYXNlIHZlcnNp
b24gZnJvbQ0KdjQuNC4yNTcgdG8gdjQuNC4yNjIuDQoNCllvdSBjYW4gZ2V0IHRoaXMgcmVsZWFz
ZSB2aWEgdGhlIGdpdCB0cmVlIGF0Og0KDQogIHY0LjE5LjE4Mi1jaXA0NToNCiAgICByZXBvc2l0
b3J5Og0KICAgICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9n
aXQvY2lwL2xpbnV4LWNpcC5naXQNCiAgICBicmFuY2g6DQogICAgICBsaW51eC00LjE5LnktY2lw
DQogICAgY29tbWl0IGhhc2g6DQogICAgICA2Yjk2YjIxMDc0YjhmN2FkNGI4ZmM4ODVkNDIyODIy
MjhlMmE2OTY3DQogICAgYWRkZWQgY29tbWl0czoNCiAgICAgIENJUDogQnVtcCB2ZXJzaW9uIHN1
ZmZpeCB0byAtY2lwNDUgYWZ0ZXIgbWVyZ2UgZnJvbSBzdGFibGUNCg0KICB2NC40LjI2Mi1jaXA1
NToNCiAgICByZXBvc2l0b3J5Og0KICAgICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvY2lwL2xpbnV4LWNpcC5naXQNCiAgICBicmFuY2g6DQogICAgICBs
aW51eC00LjQueS1jaXANCiAgICBjb21taXQgaGFzaDoNCiAgICAgIDZlNmQzZDkyMTViMmEzZmUz
ZDliYTU2YmM1Mjk1ZTE2MjY5Njk2MTYNCiAgICBhZGRlZCBjb21taXRzOg0KICAgICAgQ0lQOiBC
dW1wIHZlcnNpb24gc3VmZml4IHRvIC1jaXA1NSBhZnRlciBtZXJnZSBmcm9tIHN0YWJsZQ0KDQpC
ZXN0IHJlZ2FyZHMsDQogICBOb2J1aGlybw0KDQotLSANCk5vYnVoaXJvIEl3YW1hdHN1DQo=

--DeVyoh3pn3T18DvuOyZJ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6305): https://lists.cip-project.org/g/cip-dev/message=
/6305
Mute This Topic: https://lists.cip-project.org/mt/81518188/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--DeVyoh3pn3T18DvuOyZJ--
