Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABE9C433F5
	for <webhook@archiver.kernel.org>; Thu, 30 Sep 2021 01:19:28 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web09.6456.1632964766231229377
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Sep 2021 18:19:27 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.156, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 18U1JNL6011761;
 Thu, 30 Sep 2021 10:19:23 +0900
X-Iguazu-Qid: 2wHHtYwhjVlcgbjgFE
X-Iguazu-QSIG: v=2; s=0; t=1632964763; q=2wHHtYwhjVlcgbjgFE;
 m=rCVW3xNModVbFlc7pTIdby46z9WFUHdg+ZwyGW5x4UM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1112) id 18U1JMPJ014688
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 30 Sep 2021 10:19:22 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 1DF9A1000CF
	for <cip-dev@lists.cip-project.org>; Thu, 30 Sep 2021 10:19:22 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
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
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: CIP IRC weekly meeting today on libera.chat (2021/09/30)
Thread-Topic: CIP IRC weekly meeting today on libera.chat (2021/09/30)
Thread-Index: Ade1mQNlJ6hXrZWMTSKpf48kzKEDGA==
Date: Thu, 30 Sep 2021 01:19:00 +0000
X-TSB-HOP: ON
Message-ID: 
 <TYAPR01MB625256EEFD1D59FE6967067F92AA9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
authentication-results: lists.cip-project.org; dkim=none (message not signed)
 header.d=none;lists.cip-project.org; dmarc=none action=none
 header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6700890a-eeed-445a-d9c8-08d983b048db
x-ms-traffictypediagnostic: TYAPR01MB5481:
x-microsoft-antispam-prvs: 
 <TYAPR01MB54811B3DC8C7D4155952081392AA9@TYAPR01MB5481.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 bIaO5bawFHTGQtJp74dsg9jWEdI3qR//fYiOVf5pm1mNgq2gVpn4ISMhgbklUmOgqU6XxIa7yCeYt6uNXuhB1AV8tyD/pGQdC3TH1m2W9V9hlzrXasUOn9xF9V4fWiHLG3kDuRVMWyNnC444sHRGsuEUJb2OwppFfiy6zG+sbgY4pTRw29ZMnfh2G2ORCjel337tQx1ZKji5GaaNrzU7tqil6Twq+7B9JiansEFQsCYwUVYnM/OaHJd95vTbqY2Z43qqclNGzPKZggWlXOf0oB+6WJiEcWMzQfC8BCQKIrVjGY8+WXQYuBTFCpl+7VDLtlpevfc/LNlzNTRcqzLPBjtk8LCup3Wv3bDSeH/huikdd5TrajDHyDKb5n8iFPpr5RTTyQhHTdPXD+5WPeuake7yUjRlntjoHRo3OEQNJZszuFVOxfnp4b5XUD0XHMHt+evyxspr5x50tt5cQFh1tt/YkdTjqi4snuc53/ZNh4ICwdWFu5ETi2eQxHr+0RBa4kTMcXjNiReAgNOXAgL2oDmiXbpSsomVemywzW/+tK/M0QHcmVZ7WrpZBUJPjQG+ci7+uFWv4VLhRh3P6I2fjQi+59pBgARSvK7chIacNyiguBUWSEUnIVaXciB/t5Xsciz6XKRgt9b2KmHg37UmhxOXROh6tQraySTM028C0Rh3CHMtsUroHjj8QhH/TbKxo/tho+7TViUy9E/OkGG6LXRqkR5Et6jPvi4P+UD9WiEeF7v96SV9ChV8u5RRg/UJmVWVeRR7AR3UXJVSwSnizRAxt8MNBhOWTr6Cd6AHjCw+PkVfLNlNIyNGKZNOBqTdQ+js4fvtbyf3+ojgAB4PhA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(66446008)(64756008)(66556008)(66476007)(66946007)(26005)(9686003)(38070700005)(8936002)(55016002)(6916009)(7696005)(52536014)(86362001)(4744005)(2906002)(966005)(122000001)(508600001)(83380400001)(5660300002)(186003)(6506007)(316002)(71200400001)(38100700002)(8676002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eFNKcEVIV09vTzFQdStEbk1Xc0hjeTZ5Z29ZOGc2VktvdDdlQ3oyU2pMN0xj?=
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6700890a-eeed-445a-d9c8-08d983b048db
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2021 01:19:00.8888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 W5w1jBh452Gp/RmG0Rwp22M+tL37RMJYNJllvWfDVsnTDdM2KIxmn48hmyCLPS8KginEjVK+BvFrXS5g9ihUNKwrfo72WdDmxyCG3GRFcWeUMHTjsy8o9jC4ASZx2LUK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5481
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Sep 2021 01:19:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6763

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


