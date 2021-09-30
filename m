Return-Path: <SRS0=R3/5=OU=lists.cip-project.org=bounce+64572+6763+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB29DC4332F
	for <cip-dev@archiver.kernel.org>; Thu, 30 Sep 2021 01:19:28 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56478615E5
	for <cip-dev@archiver.kernel.org>; Thu, 30 Sep 2021 01:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 56478615E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 0zrfYY4521723xBLM1hErjlX; Wed, 29 Sep 2021 18:19:27 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web09.6456.1632964766231229377
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Sep 2021 18:19:27 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 18U1JNL6011761; Thu, 30 Sep 2021 10:19:23 +0900
X-Iguazu-Qid: 2wHHtYwhjVlcgbjgFE
X-Iguazu-QSIG: v=2; s=0; t=1632964763; q=2wHHtYwhjVlcgbjgFE; m=rCVW3xNModVbFlc7pTIdby46z9WFUHdg+ZwyGW5x4UM=
X-Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1112) id 18U1JMPJ014688
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 30 Sep 2021 10:19:22 +0900
X-Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 1DF9A1000CF
	for <cip-dev@lists.cip-project.org>; Thu, 30 Sep 2021 10:19:22 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 18U1JLm1019493
	for <cip-dev@lists.cip-project.org>; Thu, 30 Sep 2021 10:19:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbaOpB+52MMJUgX27PuCNopO9iws8gCyF41wBfuTO0V8lFM3/Y0BayQah6gPvmT0JvCiMkrHwQLc2TIC1EKCKu+Aq1+8ROszjJsFj69jkwpL6WC5W8Wk7OMN5YL/Ip68sPARQSJCZZClwplNPtt9bFaRp6/VoHLvHbFwqjZxx3JMvhaFJ3xPu9oEEPuB4I/dPMr2MowMk3qnWBrfHrRHG7uj8E7O0fCPKJJnKqxcG+xrhSsnuyft/jpf7kItQ+lyGm81gVDaO3INU25MgYfVum4Y7Pv7pLDWqlP+4px9g+lECHt+J994XTBTBo7gSZaBuKBLXKx37ZbxAChnJQlqvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=7l/+JgDv6RKaWgyYxMbU71FkyE5uv0cUELJDSPEFs2Q=;
 b=ZyvtvbUfcLH7li6Pm82fDnTZS8i4W+PsvdJVqS2oS7HBlAOLbIjf685OLuZ4ADvNrGhwBBhQSGo7QHZMTQ/TeXAFCL/sD1k7S3O8K0EOVz8Xy+ZxU/M3Q5hSYGzvISPA+ZsIj0+/PAt5m6w+GkBzcICbSGuf9S8RtuA1NBr4SvCtuOpplfK6SFBLlm4m6Ruf+Wz6FzovBDnvMfN2hxxmsd2lIeX3Qz3Mato5i7HHXo7dMxdS8XtlZmNMLwaPUXzMhaNByQQURN9ZijuUvY4tl6X8m3hVUHBSumLgx3WaARRCJ6chRVDJc191ythggJL3qC5gWYbDHan7EAVRlHpRdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat (2021/09/30)
Thread-Topic: CIP IRC weekly meeting today on libera.chat (2021/09/30)
Thread-Index: Ade1mQNlJ6hXrZWMTSKpf48kzKEDGA==
Date: Thu, 30 Sep 2021 01:19:00 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB625256EEFD1D59FE6967067F92AA9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6700890a-eeed-445a-d9c8-08d983b048db
x-ms-traffictypediagnostic: TYAPR01MB5481:
x-microsoft-antispam-prvs: <TYAPR01MB54811B3DC8C7D4155952081392AA9@TYAPR01MB5481.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: bIaO5bawFHTGQtJp74dsg9jWEdI3qR//fYiOVf5pm1mNgq2gVpn4ISMhgbklUmOgqU6XxIa7yCeYt6uNXuhB1AV8tyD/pGQdC3TH1m2W9V9hlzrXasUOn9xF9V4fWiHLG3kDuRVMWyNnC444sHRGsuEUJb2OwppFfiy6zG+sbgY4pTRw29ZMnfh2G2ORCjel337tQx1ZKji5GaaNrzU7tqil6Twq+7B9JiansEFQsCYwUVYnM/OaHJd95vTbqY2Z43qqclNGzPKZggWlXOf0oB+6WJiEcWMzQfC8BCQKIrVjGY8+WXQYuBTFCpl+7VDLtlpevfc/LNlzNTRcqzLPBjtk8LCup3Wv3bDSeH/huikdd5TrajDHyDKb5n8iFPpr5RTTyQhHTdPXD+5WPeuake7yUjRlntjoHRo3OEQNJZszuFVOxfnp4b5XUD0XHMHt+evyxspr5x50tt5cQFh1tt/YkdTjqi4snuc53/ZNh4ICwdWFu5ETi2eQxHr+0RBa4kTMcXjNiReAgNOXAgL2oDmiXbpSsomVemywzW/+tK/M0QHcmVZ7WrpZBUJPjQG+ci7+uFWv4VLhRh3P6I2fjQi+59pBgARSvK7chIacNyiguBUWSEUnIVaXciB/t5Xsciz6XKRgt9b2KmHg37UmhxOXROh6tQraySTM028C0Rh3CHMtsUroHjj8QhH/TbKxo/tho+7TViUy9E/OkGG6LXRqkR5Et6jPvi4P+UD9WiEeF7v96SV9ChV8u5RRg/UJmVWVeRR7AR3UXJVSwSnizRAxt8MNBhOWTr6Cd6AHjCw+PkVfLNlNIyNGKZNOBqTdQ+js4fvtbyf3+ojgAB4PhA==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFNKcEVIV09vTzFQdStEbk1Xc0hjeTZ5Z29ZOGc2VktvdDdlQ3oyU2pMN0xj?=
 =?utf-8?B?aDQvbStqczQ1SWJSdTZUdGhxdVlnUzNJTlhDaDlrdWtwT0tUd2NEVDBMZk1K?=
 =?utf-8?B?OWxWRVU1eHd0UVdZdTZjVXJQN0h3VFYxUEx6NzVJcXRVNGUxWnczT3oxdWZO?=
 =?utf-8?B?MUNyaHd2T24zQ3R3NlpWQUVpNmpFanVkTFZNMCtMcHJmTHY1YmtkVnJmcUxi?=
 =?utf-8?B?U1lpOUxVVlZTZGRkcVJrTUVzU1g0YUV0U0haOFQzQWxQempBeHFJOWZMSHdy?=
 =?utf-8?B?TitXVHh5RWRwclFyYUVGTDBFRFhML1NPL3dVQnpaTHFBcSt6a1NlU1FyM09n?=
 =?utf-8?B?aHZmL1gwZnJLbC9kV2h4MFFDY1l3K1hEMjdrVFVSc1BMbzVNQTZLQ2I5dDVx?=
 =?utf-8?B?T2tKV3kxeDNTM0YvZFdSdDU4SFpWdklYY1UrYmdweUE0eklpR2VRSXlsTTNW?=
 =?utf-8?B?RFVkY1JTR3MrQzZGNWwzV0NLZEhieWhNV3VzN3lFRXo1SjlpK1NCZzh2aGxy?=
 =?utf-8?B?L0orcFFWeWUyeWdvL05PQ3VtV2NvNU1PK2hMVUpteTVyaVZuME1zUHlZVFor?=
 =?utf-8?B?cDladyt6czlwKytpMXh6V1FtbGRwbGFWRFpINDVIR1loVVlzODB1emRzUXh3?=
 =?utf-8?B?ZXFuckFocWN0bWkzNHZaRU9leUw5ZU9IYzQxRmdxRGs4enJtcm5BcjQ0OWVI?=
 =?utf-8?B?cVZtNzNWbkhBblVqdjFwVVZuNGE5TERwUkJLM0dNMmpJVHBoRHk1MzN2b0NN?=
 =?utf-8?B?ak5COXNiYmNLSlVIMGR2VmJ0aXJrL0RpYi9leWdUbGlpOXNwSm5YS0VwQmpF?=
 =?utf-8?B?OWtucG1rVFhLeEdlbTJOQWx2T1Z6THZGSDdveG9QR3ZSL3hiK3ppWW1vdGpO?=
 =?utf-8?B?QkROOVB3bVNIak1WUG5YQVl2UHA5RkFUekdNcXZuMytEVmgzRGU5YkkvaFp3?=
 =?utf-8?B?WXNYT25URWtwRzM3b2hYa2Q5akdyZ3lZaXM5a0kxNzNOclZ5NzgwUHZEUWpJ?=
 =?utf-8?B?U3p0eThUU2JnVW1lWllheGtka2NiVy80Mm82OFFIenN1QVI2U08yMW40QTFo?=
 =?utf-8?B?M3RrQTNwclBwdFJVVnkwdXkvcVVVODY0U053bXZXMk5nNHpUTGJBa09QR1B1?=
 =?utf-8?B?Q2lhMUN3U3N1bURMY1dXcDV3cFZBUi9DYnJmSXY2UUUyQWhmSWJreUdWMndY?=
 =?utf-8?B?cUlZMmdocGUwVk5xay9MdmJreUx4YjRpczVQRXNXQTJHVlFzVmZIVEpRMHpi?=
 =?utf-8?B?SWo5QktiY1ZET0NhN3JPbEdTSWtmTU9PS2RKbVVwVkw1aTJTNGlCZmFYS2Fp?=
 =?utf-8?B?YWw2THlnVUdFbGNDVUhpOVdDTHVqdGo3QVVheTJIZzVXbVZtVUJaSm9uZWVa?=
 =?utf-8?B?WVNNOFJKS09aYUJ6enlpZjdpSVQzMXRKbStrVkJuRWhyYS9QVytQNWhmWmtv?=
 =?utf-8?B?dTkvUDZYTjZSSXVTTTJuYmplOFVwQXdkd1l3bFMrTjdscklaTlU0dnNscUZG?=
 =?utf-8?B?elhDV0QrT0F2b09iUHVCaXJSeTMrcVh6VzJhaUphQWVmNHNYN0Y1VTE4SXRM?=
 =?utf-8?B?ZU51NzN4N0pXaUJURU9qS0x0SVJxTDg0eFl0MG02MUJlYnVidCtFbXNSbHVI?=
 =?utf-8?B?cUtLS29QTTZBRkdOOUp3NUo5d0RFeExJVERjQktGY1pRWnk3THdpckJYYVFP?=
 =?utf-8?B?WjJ4ODM3TFVjNTZER1JIQ2pGZWtyU0NkeTNMNkVtbC9iZVY3bE5iUWgvUXU1?=
 =?utf-8?Q?YrjhV8r5b+P5OGhjKA5ovoxqMUlDnfhVzpveAN5?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6700890a-eeed-445a-d9c8-08d983b048db
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2021 01:19:00.8888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W5w1jBh452Gp/RmG0Rwp22M+tL37RMJYNJllvWfDVsnTDdM2KIxmn48hmyCLPS8KginEjVK+BvFrXS5g9ihUNKwrfo72WdDmxyCG3GRFcWeUMHTjsy8o9jC4ASZx2LUK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5481
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: fFZkHHo5dklEOgbxZUDpZ17Kx4520388AA=
Content-Type: multipart/mixed; boundary="T7lVmUTpfODoircKbDc6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1632964767;
 bh=qkI1cdF932djlrrf3+0CSxEGco7za6HJIj6Bh8kH0Rc=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=mtlAOmNHsnS3QzRsMsu/rwNXyAbUv/jc5Urv49gH/QfKVRCTl2f3Uz4GvpI0gmHLBri
 PVEDKT+AjGUhT+8TFfxySoCnIupPpk6nek4Iz4a4Zz+kqvxLquugEWVyrZFHhsdxmZRzE
 4M1Cu1dSzkBJ3d6VKlj/fZySEXo5/zCguWg=
Message-ID: <20210930011900.-Rk3MHYIr1rb6CN9Op7Vam_yjaWy0gBaKuKvXrOCj40@z>

--T7lVmUTpfODoircKbDc6
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpLaW5kbHkgYmUgcmVtaW5kZWQgdG8gYXR0ZW5kIHRoZSB3ZWVrbHkgbWVldGlu
ZyB0aHJvdWdoIElSQyB0byBkaXNjdXNzDQp0ZWNobmljYWwgdG9waWNzIHdpdGggQ0lQIGtlcm5l
bCB0b2RheS4NCg0KUGxlYXNlIG5vdGUgdGhhdCB3ZSBtb3ZlZCBmcm9tIEZyZWVub2RlIHRvIGxp
YmVyYS5jaGF0LiBPdXIgY2hhbm5lbCBpcw0KdGhlIGZvbGxvd2luZzoNCg0KICAgIGlyYzppcmMu
bGliZXJhLmNoYXQ6NjY2Ny9jaXANCg0KRnVydGhlcm1vcmUgbm90ZSB0aGF0IHRoZSBJUkMgbWVl
dGluZyBpcyBub3cgc2NoZWR1bGVkIHRvIFVUQyAoR01UKSAxMzowMDoNCg0KaHR0cHM6Ly93d3cu
dGltZWFuZGRhdGUuY29tL3dvcmxkY2xvY2svbWVldGluZ2RldGFpbHMuaHRtbD95ZWFyPTIwMjEm
bW9udGg9OSZkYXk9MTYmaG91cj0xMyZtaW49MCZzZWM9MCZwMT0yMjQmcDI9MTc5JnAzPTEzNiZw
ND0zNyZwNT0yNDEmcDY9MjQ4DQoNClVTV2VzdCAgICBVU0Vhc3QgICAgVUsgICAgICAgIERFICAg
ICAgICBUVyAgICAgICAgSlANCjA2OjAwICAgICAwOTowMCAgICAgMTQ6MDAgICAgIDE1OjAwICAg
ICAyMTowMCAgICAgMjI6MDANCg0KTGFzdCBtZWV0aW5nIG1pbnV0ZXM6DQoNCmh0dHBzOi8vaXJj
bG9ncy5iYXNlcm9jay5vcmcvbWVldGluZ3MvY2lwLzIwMjEvMDkvY2lwLjIwMjEtMDktMjMtMTMu
MTEubG9nLnR4dA0KDQoqIEFjdGlvbiBpdGVtDQogIDEuIENvbWJpbmUgcm9vdCBmaWxlc3lzdGVt
IHdpdGgga3NlbGZ0ZXN0IGJpbmFyeSAtIGl3YW1hdHN1ICYgYWxpY2VmDQogIDIuIERvY3VtZW50
IG5ldyBMQVZBIGRvbWFpbnMgaW4gd2lraSAtIHBhdGVyc29uYw0KDQoqIEtlcm5lbCBtYWludGVu
YW5jZSB1cGRhdGVzDQoqIEtlcm5lbCB0ZXN0aW5nDQoqIEFPQg0KDQpCZXN0IHJlZ2FyZHMsDQog
IE5vYnVoaXJvDQo=


--T7lVmUTpfODoircKbDc6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6763): https://lists.cip-project.org/g/cip-dev/message/=
6763
Mute This Topic: https://lists.cip-project.org/mt/85964342/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--T7lVmUTpfODoircKbDc6--
