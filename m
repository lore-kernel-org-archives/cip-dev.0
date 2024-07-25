Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BF7C3DA5D
	for <webhook@archiver.kernel.org>; Thu, 25 Jul 2024 06:26:45 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.30121.1721888802053278648
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Jul 2024 23:26:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=DSm71ujY;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1721888794;x=1723098394;bh=6Mcq7MxLnXOW0v/3KZliaVXahswhxGh3QOO+nDW
	hr/Q=;b=DSm71ujYmPK1F98n0dx2ggVMF3+p+5wDM7vdFBJt1yS+D1kMI0pAtn4v6WHBBL/oql3Py
	ksfX4WkWVE/vwL8K+qp1eA0LSsynIjbtWQeZ/weHSao0hweLGpVzfhYoUvvA9ohRWO7+TQE2H+RIp
	ZDMKj5ZNChj2Qfqw6jO4avNMgQjoSA1yUxuK68kINAo519Ol5cnId6f7GEs+5cc4qlqbi4M7L6Gdu
	2SAHA3mlC417N8hdvag/ZAjie2BI5bhgmOiWBORcqJ8E7mUir5rZZL7x7s+LjPfFw1KrhW4BPyxPU
	hGhrW2kVm3LmuavleO6oCVY7lbQrDRYH7Ox8NXjAow==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 46P6QYoZ1447328; Thu, 25 Jul 2024 15:26:34 +0900
X-Iguazu-Qid: 2rWhGh6hBzUjmJL8TO
X-Iguazu-QSIG: v=2; s=0; t=1721888793; q=2rWhGh6hBzUjmJL8TO; m=KBPkNyjfFcOxN9P/0swOViIcuR1IZWCWdrVk5k2DhMA=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 46P6QWa0845419
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 15:26:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVpweetj+0mNfjgJ9KVogI0rL+VXpcxDXUbMjWaJDqO/9iJOVNkQPAgRvWsAYmhE0iSHpfsRrviGutSa2BJF0qnV4W7AmlfpzjUN0l13l3MS8TATxrN4uafHwUq7K+OdkDnQzmBuGPgQnqPiDcfJ2yI2rlqlmNxSRihJADpq1xhmynVkJlzzpl8kjQ/JnoUnra9Te2WyIrWeDuHX5HEe221bwZ6N3iyYmz79eaLnuH69R9tcHKD20moBberiG8YsecdM3t/aBfEBAM1MaUhDxPNNYYVZ8bS/NzoaWFNmqafOSq9FYv0yfLcU/K/C9m4zOvgczNKLRpyCXoynCK8uxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tka/HFHVFhvTefaaOlHdvEGS6A+ilKGMjw8QBDsIoxo=;
 b=RaCvHmCNJhvQdn0avMnQn1tvfGY01QpqIdeC26oa9arHZoXY3wIpRrYknGboh7KqUAFuF32DsYGPcXc0gb3Huoo8Plz/j/HfKLmZ1GyTl2mMTtR+kmc5hNqEfx8j3FQasgFWOC99sbSZgDF2gRHiiWHpjHVT7fcKkQBsC7KBfq0+IVmpB+L9OZDxW7+bC1RYl1w7JPbBbtQeycb8UjQWHaT4NQ4uZikXom3r0mYtKoAhTrjsLkxvGVpHXv35i+vTIPjidoSGzT7dWo47DVRWC/LU1+38AZuAh5Xrr4C7ZJg6NgNDpPAkmVn8SUcnbVHbL8nWPt0bJBcN4P9V+ShXPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 0/1] Revert "Add missing cache-level properties"
Thread-Topic: [PATCH 6.1.y-cip 0/1] Revert "Add missing cache-level
 properties"
Thread-Index: AQHa3amsRJ+MIJsOA0+uvLixgSQ367IG+3IA
Date: Thu, 25 Jul 2024 06:26:30 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388066F05403DADDFC30F9792AB2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20240724091240.67115-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20240724091240.67115-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OSZPR01MB9472:EE_
x-ms-office365-filtering-correlation-id: 7dc6cc57-c6e3-43f1-6475-08dcac72b8cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?WFdWSkRBcVppNHl5NEtsL0thejNyODRncXdmMFhtZ2VKTWxuT21EOHlz?=
 =?iso-2022-jp?B?QUtRNnc0clc3cDl2dlNEa2dpa0hDY2VsZjltQ3NjRFpQV3lNUzRxTE5t?=
 =?iso-2022-jp?B?NDllTzlvc0g1V1BSaFVHT2VrektEZGFFZXBTZjhJbnY3VDgxVVlaZDh5?=
 =?iso-2022-jp?B?RmFMR3lFY1JtbHhleWR6RHdFbUJTUkwvQWRYS0VXZHVZRVZMWjVQY2w1?=
 =?iso-2022-jp?B?cTBvdlJkT2w4cE5paGFXR0ZIRmhVSmdlN1dFcnJKdGpQYVNVdEVTdUtz?=
 =?iso-2022-jp?B?dXY3VWs5REhQOVFBd0VlTmRITjZmOWg0T2RNWUw5d1ZqVWNodmtPREdJ?=
 =?iso-2022-jp?B?Q3c4eHpOR0s3eXBzekFOYVUvclEwUkJGb2xjaVJPQlo0b2swM0NvbFdv?=
 =?iso-2022-jp?B?c0JzYWNqK1NJUk0vVEJiekk4TnNsMWIrRGFKV1hjVEovZ0NPaitBeS85?=
 =?iso-2022-jp?B?b2E0UWJhK2M3U3JSd1F4ZlRUMzNNNlZxKzI5eGNkVlNBWkFxSUQvWm0x?=
 =?iso-2022-jp?B?MmJDanRHTG9wVjdLYkZUVGhlUk5IL1Q4VXA5TkxxVG9xaTMxNDJuUnAr?=
 =?iso-2022-jp?B?MCt3Zm1LNnZYUHpJcERNZzM1UzFJMVpXVjk2ZTdrQng5aHhXUnBXcHFN?=
 =?iso-2022-jp?B?ckVFT0Jjd0hCWmVqK080QkRwL3NvaFZHTnVtZ2xzZGx6dVRFZWFtMW5a?=
 =?iso-2022-jp?B?S1hHaWtiekhJWm1MWkkzZ2FwU0J2NTRjQ3lHSEsvNFd0emxiaHBOUGRy?=
 =?iso-2022-jp?B?bmczNkZXSE5tV21MUDRQMGFoS1hnOTdJR3Y2aFF3eGJ2SU5KL0ZnZGpP?=
 =?iso-2022-jp?B?amF2WGoxWE1uelRVTzU3WC9oK1AramFRR0Q2VE80eVZFcG5aaHlYcEky?=
 =?iso-2022-jp?B?UkcvdzI2YXZKL3FuQXNZOHkzOHlUODgrR0lpcUdOTFlndDkwYWt6RUtl?=
 =?iso-2022-jp?B?Q3NTM3pJRGRMQktOK0xVRHdEM3hDS3V5MjQrbE1PRnQ5WHdGdnI5Umt1?=
 =?iso-2022-jp?B?aklHZWVlaDJCUkoyci9TcEp1UE5qS2M4WjR4RnFhR0NReDg1dkJNNDE2?=
 =?iso-2022-jp?B?K2JxOGs3SE15NWdJZnRhVlJkclkyWUNydGh2Y3luT3ZoSVkzZmNUenhv?=
 =?iso-2022-jp?B?ZjVTYkJkbkZRbzE2Snp6Zm1QNDZ0b0ZIUE0zUXhoQVF1cHordlVZY1Ju?=
 =?iso-2022-jp?B?cUNaWmdnTzlpK2hQZFA4aU0raWJ5Yk02MnUzOFJsb0tIMVJ2VVp2SVIw?=
 =?iso-2022-jp?B?elpKWmtJeTFKbHV5YXRheEE0YnhpRlRBeVY3Uks5ZEN0ZTNxOEErN1g3?=
 =?iso-2022-jp?B?eUE4dXh2enlCWmhtRnREU2R5S0JGbFJtUDRnTDFOSVMxTVE3SzBEcWVx?=
 =?iso-2022-jp?B?SWhWemtFUG5xWnNIaHpyU3E5c2NsRWtUQURaNDdWMDFFNWF2Q1dWWThY?=
 =?iso-2022-jp?B?TTJtKzlva0YzVzIzY2hCWFVYVTNpNFNpMGNsRHBKZ0EwczQxVmlLVWVh?=
 =?iso-2022-jp?B?Ryt4U1dLQkNjUFdDVlBiSTM4WXcySElJcDZVVjlVeldZcitkM0xodVQv?=
 =?iso-2022-jp?B?ZTBHRmZaMVlob2NLZ3RuRlBVemt5RVcxZkFPc3luZEYrbDR6cWR2d1FK?=
 =?iso-2022-jp?B?ZTRMck5VNGg4cHppb1I3Y3pzb1hqbVFZclQ5ZU8zemNRTFg4MytzMlQw?=
 =?iso-2022-jp?B?dnBXdi81UllHUnQ3WG15UXBMYjBoTnBVbUxzSndyc00vbExHS0szWUs3?=
 =?iso-2022-jp?B?c0tmTk9LdkRpU1hZaUVEUkF6VmE0K25ZdnFLUnRaYUxuVFFYaC9mbXJY?=
 =?iso-2022-jp?B?cEEvbGN4Tml2aHIraDl6S2NZak43V2RpTEdpemZXRjNEcWdFcEd3cWxw?=
 =?iso-2022-jp?B?QURSZkdvRHgzQVhwcFFvOHJxSnZrTmZBOWowSitBc3lJcVZmeVkzYUU4?=
 =?iso-2022-jp?B?UXJrVlNQR2o1akJHTytFSDlaSGpWMlBwbGJMaUN3bnZQOTFtMkN2ZWVn?=
 =?iso-2022-jp?B?ME1zQzlKVlE3bmhjRDQ2NDNNaFY4Z0lBQ1VWRGJEWTlUcS96UjRTSkMr?=
 =?iso-2022-jp?B?Sy9sZlVxc3pyYW9XeEIzRStPeGVTSndLS0dOeVFLcVNXRkZjSlZHMEc0?=
 =?iso-2022-jp?B?Z0U=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?cHFNVnVZUldCSEh5V2dZR3c1amxnNDNwYWc5VUdOWFNEZ0tKMkMzNlRG?=
 =?iso-2022-jp?B?VXN3SWl0cnFURkpzSE8wWmNTTzB1L0lKaDhpNmdCQ1pxZEtYcURTUDJ5?=
 =?iso-2022-jp?B?R3hRR2F4Z3FKWnlnNGlEMkZnbHptWG1salFNSUVXTUl1eWVnTTVQMUla?=
 =?iso-2022-jp?B?WkhxSkdpbjliYlFRZGxOUmFvV0sxS3VXcUsxRks0WENGSlRFRmo3eUJJ?=
 =?iso-2022-jp?B?VkJ3V3BpcTdMK0paZVZmODRXRm5DeGh1YlVmRmRjQlIrVHlBSjNyRXpR?=
 =?iso-2022-jp?B?eExsMTFpcHZqYmZZclRVZ2x5RXVUSHpDdm5Ma0FyNVdObytsSVBQWm9h?=
 =?iso-2022-jp?B?OVpONzU3VzEwcUdVbTZtdUdyeFdsQVhDcDhKNE0wdkhTV1hqR3hXaVNr?=
 =?iso-2022-jp?B?NHhyQXFzSDhxWFQ4TTVjU1E1Um1UVGc4MWpBc25LdUcrRnc0L08zejQv?=
 =?iso-2022-jp?B?eUF6S1Flb2pQOXNwaTRPTURpYzVnYTVJd1JnU0RHUkppM1plTlovTWVB?=
 =?iso-2022-jp?B?NGYwOElpY2RabTRpQ3hhQUJTTkhDU2pWbkJsSnVoUkRNREFZS21HRUl4?=
 =?iso-2022-jp?B?YW5uc1haMGtwUWNXVWEva1hiSWdpTHJDc2tnbUFpUUtEYkI2OUt2Ym55?=
 =?iso-2022-jp?B?TGk5N2NxVm85dnJEZmxHQ3dXZ3JaRDBqSmdqYzVTTnJWamYvUDNEcTNI?=
 =?iso-2022-jp?B?b25DK3VaSi8zb0JSK3pYdDdCMEFVK1J2TGg2UVlnSTRVdkZ2K3RPN1dV?=
 =?iso-2022-jp?B?K2xPWVl0THhtNzZINUZHb2ZsVUkxNVJpRWthN2poVWY1SmZ5QmtXb2l6?=
 =?iso-2022-jp?B?alNidHgybEJlZFZIemdYTUFKWGwwMTd1YXBjbjF6Y0tCelRDeklKVktB?=
 =?iso-2022-jp?B?VnF3VlJsdTJadnR2WmlSYVAyaCt0RnREUGx4WWpzUTF4UG90VFoySUVX?=
 =?iso-2022-jp?B?WElrbTQ5dDdISHBMbDl2cmpSSkF2U3BrRzJ3TStqNGw5aGVpQ2FzUHM1?=
 =?iso-2022-jp?B?aEE2ZW5lT2V3cWZETE9va3U4NDNBd0F0bElBSTlmRkU1ZXB3MU1MT05K?=
 =?iso-2022-jp?B?aFAwWlZ2Wnc3aE5TN0dpZXdSRUJOYVB3UTRLcG9KZlVYVDRIY2tmcG14?=
 =?iso-2022-jp?B?NzU1azF2U2F6RjVyOUNHeFMxQnJrd0s2ZU1qYlR1ZlRqWkZGcHlPMThY?=
 =?iso-2022-jp?B?bXp1WVZ0VVpaTFpvUlQybWRFRGJ2TUVnK0lhOEpwalNCYnJwc2tlbytP?=
 =?iso-2022-jp?B?ckNSZ1FwdGlCVE9HV0Qwc1Q5TmVNeGZtZjk3UHgxRlczTVBvbFRzL1lS?=
 =?iso-2022-jp?B?czZPbkZZdUxCd3JqaDNVeXhiLzM1bWliT25NZERlZi9RREhwY1IzZm5I?=
 =?iso-2022-jp?B?N011RTVnV1hJMkJMQ0wwS2xIOHNuQkdKQ3FHWW9XNzYwTHpGZlVWTlpF?=
 =?iso-2022-jp?B?VzdYb09OSnpEWlpSN0ZRMURjNWd1TVlISFNFQWdwNnk0UVBsUytOdzF5?=
 =?iso-2022-jp?B?QUlocDVkeUpsTkU5bWVHa3hhY0ladXh2aWYrNWYxdGFXblByNFFvUnFh?=
 =?iso-2022-jp?B?VEUzUnQvSW5KZXpEbTQ3ZHR1cjVhcjZhbDlSM1pLL0xlSUZ3Ull1UXUx?=
 =?iso-2022-jp?B?WWZvcjNBYWs3MmNXZzJaMUxvYWJqYUpCYlpuV2dxY2t0SUY3a2pEekRm?=
 =?iso-2022-jp?B?ODE2Z3VvdEd2L2NiaXlPYm1rVmhTczVwcURpbEVmUGt6aFg2dlRuSDly?=
 =?iso-2022-jp?B?aVpqc0d2bnpHSEZDc2RwU3BjUWxRWmg0ZVJNM2o1ZkZ6N1pGcGlwVHFk?=
 =?iso-2022-jp?B?VHBoUVVmUWtvQXBwdEs4RG51RnVPYXBqRW5lZjRDZlpFL254dHJMeGtw?=
 =?iso-2022-jp?B?Zk1Ib1VRaDRlMEhzSFJlNzlWUkNaRmVJL2hyTnJ0LzdzaVNweVFGLzlj?=
 =?iso-2022-jp?B?ZWF1ZnNRMVhJUmkwRStkeXEvYnhvNnAxSHg3UmNOMEoxRGhlRnlwb3Er?=
 =?iso-2022-jp?B?M21nNGxhMkpaUFo5cStvMUJ4S1FJREhucVJFd3VtREJPOXZnYi9URnc0?=
 =?iso-2022-jp?B?QWJoMFVPdkdUaFdGL1pPZW9oeWFnQWZ2WGgrNTUxSEd0SHFma2NPZ3Bt?=
 =?iso-2022-jp?B?OTFaMHVZc1p2NUZXbnZkM3dOKzVsdXg1YlNyK3JUNE5CMVhFU3NlNUFD?=
 =?iso-2022-jp?B?YUQrVXY4RUN6NFRJR2pWM1RhZUdPcjlwVXRBNkJDOHNqc3MrYy96SlJj?=
 =?iso-2022-jp?B?WXpSOXExT2JkUjZna1RXQ29rYVFHTzBoU1RwZ2Q0SzY0aU9mVElldUJN?=
 =?iso-2022-jp?B?NS9tU3FWK1RscjVnUjd4SXhFY1RGd2VUTWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc6cc57-c6e3-43f1-6475-08dcac72b8cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2024 06:26:30.6124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3kury8v76ZzPagjKVP/Pk5jODv7lbPvXrpGrIP4Ppxjxbrj0qW523kvyHP8XIcICwKBwUM9C4tjmxqLsOTe74VOfmiC1U1vQaiGL0eajxq7zLBmne4zt2H2PC6DXCUbu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9472
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Jul 2024 06:26:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16618

HI all,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Wednesday, July 24, 2024 6:13 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH 6.1.y-cip 0/1] Revert "Add missing cache-level properties=
"
>=20
> The patch series revert the commit f703a1ddec6a ("arm64: dts: renesas:
> rzg2l: Add missing cache-level properties") as it is triggering a warning=
 on
> linux-6.1.y-cip "cacheinfo: Unable to detect cache hierarchy for CPU 0"
>=20
> The the proper fix needs backporting generic/architecture-specific change=
s to
> support the "cache-level" in device tree.
>=20
> Mainline patch[1]-[5] fixes the warning message, but there is drop in eth=
ernet
> rx performance on RZ/G2L SoCs and also triggers another warning message
> "Early cacheinfo failed, ret =3D -2" on RZ/G2{H,M,N,E} family
>=20
> patch [6]->[9] fixes the above  warning message. Still we left out with
> ethernet rx performance on RZ/G2L SoCs, which needs backporting further
> patches.
> Since [1]->[9] impacts all architectures, it is better not to backport th=
ese
> patches on linux-6.1.y-cip.
>=20
> [1] commit c3719bd9 ("cacheinfo: Use RISC-V's init_cache_level() as gener=
ic
> OF implementation") [2] commit fa4d566a ("ACPI: PPTT: Remove
> acpi_find_cache_levels()") [3] commit bd500361 ("ACPI: PPTT: Update
> acpi_find_last_cache_level() to acpi_get_cache_info()") [4] commit
> 5944ce09("arch_topology: Build cacheinfo from primary CPU") [5] commit
> 6a249151 ("Revert "riscv: Set more data to cacheinfo"") [6] commit 3da72e=
18
> ("cacheinfo: Decrement refcount in cache_setup_of_node()") [7] commit
> ecaef469 ("cacheinfo: Initialize variables in fetch_cache_info()") [8] co=
mmit
> c931680c("cacheinfo: Add arm64 early level initializer implementation") [=
9]
> commit 6539cffa("cacheinfo: Add arch specific early level initializer")
>=20
> Biju Das (1):
>   Revert "arm64: dts: renesas: rzg2l: Add missing cache-level
>     properties"
>=20
>  arch/arm64/boot/dts/renesas/r9a07g043u.dtsi | 1 -
> arch/arm64/boot/dts/renesas/r9a07g044.dtsi  | 1 -
> arch/arm64/boot/dts/renesas/r9a07g054.dtsi  | 1 -
>  3 files changed, 3 deletions(-)

OK, I ack this revert patch.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


