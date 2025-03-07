Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C82C282D0
	for <webhook@archiver.kernel.org>; Fri,  7 Mar 2025 08:29:57 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.65])
 by mx.groups.io with SMTP id smtpd.web11.6810.1741336192649709255
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Mar 2025 00:29:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=o2E3Z9/V;
 spf=pass (domain: renesas.com, ip: 52.101.125.65, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbcBq2AuMl14fUD+Sq84AOJGJf/3OVnq9sRm17gD5y+3kyrESQP+6k7q9905uLeAAMDTaFxO6TETVQsWRD+k+ETaVOT75AgdVNmas+5dpefy8eJhDa1W8QoY+YLzfUhmUktTXECCeAyI9lx/mgPTsdQCkz71K6fiijWWDKBp7AFFxujSoslVlB/IUcWopuQrEk+K2xlcm3ZQOLoLRC/beozhG+2U1ZmfVt7Zg3/2d1avs8OwqKTR26q5TyMQyPuOsIzIfAGzpEExUTKyxJH3vqmV1tR+O0hL0xN9cVjWvfGp4iRko9Sq5fu+RHKlN/LwW37RLc76+6PfMvlAFJ77bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrznXRWIiVWeNqZ5wELaGefnw8BgWfrCwwBZOwsYZNY=;
 b=R06WZtHDmGhADRf/yIIu0cUhNlXCA3knssbAOw4v0ePYdBaP9LtTwDGLMWGfjcYvba+ZzAoZRpYbT/EnZkd/Ln7AncaJzsB4hs9XZCjfk26Wng6olwNbYQNlrFJR0aYjngSPnWRLeXxaHPYgsKOkTkGJdU+Wds3RX6r6OnFKTmhYJfSLb7SAt7aj2DIc5Ey8vbHUJZEAoUfToqWwloFnzFikTtpjRklDtxkNEnfbJJwMzmRxLJ8RW+nnMBBYA+LCYdIF33h8eJ/r7ld2EWHoUIamiMrt6yW7iPa7KUmPZ6c9WngoGJC/orwp7ed4C6Xbzsk2zI61Gf5VJ2EDNbVM9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrznXRWIiVWeNqZ5wELaGefnw8BgWfrCwwBZOwsYZNY=;
 b=o2E3Z9/VLb+2HXVtosgick4TLNW7jiy8vLY/DzEe5/kgeKNbYTuKH9GOnGeC71z79S141d03F6t/obrw2RG3G1bWEuvTj/hu1ZLPKUGGu7dOoqaVfBxJW+eAiBXzfh/OAL1qdSR+5OPrSiM9e1DMOs+lcpM57J/RiNWhZTq5HHU=
Received: from OS3PR01MB5896.jpnprd01.prod.outlook.com (2603:1096:604:c6::8)
 by TY4PR01MB15275.jpnprd01.prod.outlook.com (2603:1096:405:268::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 08:29:48 +0000
Received: from OS3PR01MB5896.jpnprd01.prod.outlook.com
 ([fe80::1b62:57c6:c2cf:641b]) by OS3PR01MB5896.jpnprd01.prod.outlook.com
 ([fe80::1b62:57c6:c2cf:641b%5]) with mapi id 15.20.8511.019; Fri, 7 Mar 2025
 08:29:48 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "Shivanand.Kunijadar@toshiba-tsip.com"
	<Shivanand.Kunijadar@toshiba-tsip.com>
CC: "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
	"kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>,
	"Sai.Sathujoda@toshiba-tsip.com" <Sai.Sathujoda@toshiba-tsip.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: Add trixie OVMF keys for testing 
Thread-Topic: Add trixie OVMF keys for testing 
Thread-Index: AduPKv1Bhwt2OQq0QKq4V/WtZyorngADrqDw
Date: Fri, 7 Mar 2025 08:29:48 +0000
Message-ID: 
 <OS3PR01MB5896B41E4172736E3AFCE042B7D52@OS3PR01MB5896.jpnprd01.prod.outlook.com>
References: 
 <TY3PR01MB1107521441FF10362116BA904C7D52@TY3PR01MB11075.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY3PR01MB1107521441FF10362116BA904C7D52@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB5896:EE_|TY4PR01MB15275:EE_
x-ms-office365-filtering-correlation-id: 45ba43b6-f9f8-41b0-a40c-08dd5d523943
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|13003099007|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?bjROeFd4MG12aHRmZnIwNk51ckpRUFNvRTNxdjN0MmNUK29IYlRHM1Uz?=
 =?iso-2022-jp?B?Y2twTHo0clpRMXo3YkVvemNRZ2dXMDNEZXYyOUpNZ0lhdU9oZjN1NnJk?=
 =?iso-2022-jp?B?d2RaY1ZSWk9tb040K0VnRUxHb0JGTG53TWZzVGNzNVVBYURGQStKSXla?=
 =?iso-2022-jp?B?YzJtb3FqZTJ3dGVRT25LOXIrTkRJOFZoMXVsNUNlbHNmbHREYzFZQWlY?=
 =?iso-2022-jp?B?Z1RCVEtlbkY2ekRYQ0ZTVlZVdDlWZHB0cVpPRVJXS1BqYzNUYW1CRDFr?=
 =?iso-2022-jp?B?cFkydEp2eG1nYm1LZm9JN0ZDN3pjVmhpUWI0VnVHNkRhR0NEeERyNlVQ?=
 =?iso-2022-jp?B?TEVuTy9hVVMvNWJYeUhteE1URHE3dHR0Y3lNRit4M0RlR1h6RUxMWXN0?=
 =?iso-2022-jp?B?Z2tzL3RDVFE0SGNacVhzTkRSSDFPczVsUDdGUTRTRlRER2hTNHZ6L0U0?=
 =?iso-2022-jp?B?dWRsV0VFL2svd21oZ2ZraFFwZnZpaWxQL0x1a0tKZ2tjdVY1NUdPVmF1?=
 =?iso-2022-jp?B?YlFhRDg5ZVd6MVRiRjJlR1pQMjRLWSs0c3Nta01reVhpZ1I1Z2o3bVgz?=
 =?iso-2022-jp?B?NllnZUlFZGlWWXBKOGVaVjVyVFo0U3NBNjB1NE1BenRHbGFBU3VkU2Nn?=
 =?iso-2022-jp?B?SU83TjlCSitFeGpWbUxGbDJXUU1WUmFKcUVsSlB4Q2p6WGp2VzkvQ3JB?=
 =?iso-2022-jp?B?OERVTWJiZmwyUHdwMkh2ZGMzWkVnWUZuWTRMRWxBMUFpeU1OZWlYTDR6?=
 =?iso-2022-jp?B?TEJFV2JKR01Icnl5SHkvTXBUQTJ2ay9tMEdNTE5vbEtpUE9BNkMycURM?=
 =?iso-2022-jp?B?Y3NPS0NwZ05heU9Ob1hic3NDc2tIeWFpM0dNcHlZQzdSQngrNy9PQUxa?=
 =?iso-2022-jp?B?OWlFdHJPU3pXRlBBWjRmZzFJTWdzZHdiODgvV1pOK3oxZG9GdDl6dkVs?=
 =?iso-2022-jp?B?bFJPMCtZVEFJeGxtOVV5VGpYSjZiNjJpVklDNzUvZnVyWU9vMW5VWGVy?=
 =?iso-2022-jp?B?SnFYT1ZkOW5KQm1qMUs3Y04vdGVCaG1WS2NzVG41RmJudm5rVTBVWnVz?=
 =?iso-2022-jp?B?V1F4ckFDejltM0xHVEYzMzlWK0hveGk1NXJORWlnVUxQdFVPMFdWb1Zh?=
 =?iso-2022-jp?B?c0dBVUtPQzc1MDJSMEQrbVkwL0xLcUlUU1dKc0g2K3UvRDg1S2JuZDhP?=
 =?iso-2022-jp?B?WHplcUMrTmszQTVjN05hamlFQVlQSXE1QVhaNjdBOW81Umx5Ymt3OFVp?=
 =?iso-2022-jp?B?aUdFdm91MjkrcTJKNGVTa2UvWDU2c21lM1BnTXhhTFdtdS9ROFVITEFZ?=
 =?iso-2022-jp?B?WFFqNDgxZG5KM2N2ejlQVU1XQlZRTlJEcSttNUg1ZEFUZXV1dmttRkdH?=
 =?iso-2022-jp?B?cmVXL0VybWpkVUpNbWk1ZzBPaVpSVHdRWm1SRHVUYkZveVMzaXRoUVVo?=
 =?iso-2022-jp?B?N3RJMlZNSmFjTDVzd1NOdHNNYjU5cGY0ai9vOWtlYXV4OGVMWkx3ZmR2?=
 =?iso-2022-jp?B?YXJWWDUvTFF4SXFFMHJ6K0x1bDJDNE95aDV6RGtqQWVVcjRiWDdJWEJV?=
 =?iso-2022-jp?B?YmZCbjZ0Slh1M25hMW5CUi83NlNnVmM4bTlJM2htTWU5SEVDd0FmWTdp?=
 =?iso-2022-jp?B?ZmpSclJ4TW1neEpwaXJGeC9WSDFYS1NHcXQyWEF0STBGUkNXNU9RV2hJ?=
 =?iso-2022-jp?B?QUNpM0Zya1d0dVFoUFA2VUEwREFBQ29TY3FsdEh2Yk9za0w5V1NMc0Q5?=
 =?iso-2022-jp?B?dUNDNTZrQzd1TWEvZ0d0MzFyZnQ0VXVoQnp6akxEU0hMTDIwcm5CcVF0?=
 =?iso-2022-jp?B?bU1RUjlWb2F6K0piVzAwOEdUN3hseW5ZZ21FbER6ME84a0lBTUJUNkRt?=
 =?iso-2022-jp?B?NmsvVXFpdEovakl3VlIzcjBlcW51UjV2MGNRa2xJc253S3lIWU5LNTAr?=
 =?iso-2022-jp?B?UHgzSFI0SkNROWM2ZFA5Q1drYnNZdnYyM3ovQjM3ZkNtYmlKMzB0NVh0?=
 =?iso-2022-jp?B?bTNQVG1saGQvc2E5eitJVjdRL3Bab2lRMk1ORGJobjdyMkFwUUtGTVNO?=
 =?iso-2022-jp?B?ZGc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB5896.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?eHp2aXlYRThweXdqUWdrTGlhanpEdzM3ajF3c0VsanB0S21ZMXJLSVNa?=
 =?iso-2022-jp?B?aXNuUmJBR3hUZmZlTjlBeXJzNGlmWGpzWWZJODFSL2FIMkpmSmtkdk9z?=
 =?iso-2022-jp?B?a1ZBMU1vZEY4WnFqNTNQcnhLYUlSRXhzYVpxZ3NUWnF5MlJlb2NRVlVv?=
 =?iso-2022-jp?B?M3Q1YWFVTVQvWVdyVEg5Z25TKzdnaFdLb2l6VWM3WG5LanpCcVdaNkFI?=
 =?iso-2022-jp?B?YUtleVJNMmVTZDJ1eEhqSUZDOUZuSTBSbk5tbWNkVTFtbWpNVmQ2MUMr?=
 =?iso-2022-jp?B?bEZ1UHRJYnEvYXM3U2tiN2ZwKzV6YWZmKytiL2RLQWl2N0lCbDczZ0RF?=
 =?iso-2022-jp?B?Uzc0S3BsaWRTMnRRc1BzV3pxandGTjFqSzV2d3pyYTJHVkw3bWpoMS90?=
 =?iso-2022-jp?B?NWt1UzExWjZXYTcxcG80UXBBRng4RGNMQmZIQzVmdklCdjg3eklJdTNO?=
 =?iso-2022-jp?B?N1FsWmNubkkvZG1CdDEyd1VxcFBMd01TcU5XOXM2MHhDOG5tTFVHWXR4?=
 =?iso-2022-jp?B?c0RWQ3JURTlPMXh2NFZQVUZUTS9XZFhSNURqOHRqRFo1UStNdnl4aE5q?=
 =?iso-2022-jp?B?cWIwY1B4ZjVRazVKZG04SytYMkljbWgrV2hrcXB3WFZBcDBoTnFTcEZD?=
 =?iso-2022-jp?B?aVpSWW0rd0dqUVViNnBMc0pPZUk4Q1J3QVdLNEhha20yc0JnRENLM096?=
 =?iso-2022-jp?B?QVlwOWY1cWZtdHZQc2VpTE1yUlpRQ1JlS1ZoVWt5SUYzOXlZbzRGb0I4?=
 =?iso-2022-jp?B?YlM1VSthc0hGdnJueThxZE01RkFYYllaSHFZTkVqeEc2UE8xM2JHd2hS?=
 =?iso-2022-jp?B?SEZwQjJxRkd1UFcrVmExUm9IeWtiZkh5TkUvYlAyL1UxcVFmRURpVldF?=
 =?iso-2022-jp?B?ZDIxbVdrb2lTMXBPZmtJYkdLMStoTHhTRU9FZGoxNHM1MlN2WENCRS9G?=
 =?iso-2022-jp?B?akc2QS9TUGVUR1ZjUTkzK2F2aUFVS2FxL3ZCRWc2V2VYYVhWbzh5S2px?=
 =?iso-2022-jp?B?SThJUHlqdVRBcXY0T3pxSnZFQ05qQUZLZjVmQkczYUNUbWpGTmtiakFM?=
 =?iso-2022-jp?B?Uk1rRWV2QXVwRnBXMkhmQWFySFhPeGR3amx1ZldKTlBmWGpwa3NRdDcx?=
 =?iso-2022-jp?B?NHhzbXgrV0Nxc0xnZHhGQWFkK0c0bDBFQnRJUW1sVTNncFNvdllNRWk5?=
 =?iso-2022-jp?B?QWJOcXBmOHN4cHd2RVBVQnBMaFM2dGNRZEp0dHE1Q1JPeGx3dGNlR3U4?=
 =?iso-2022-jp?B?ZVQzUWJsb3EzbkNSWnpGRHZLSkllbzBuUnNOSTkzNEVrL0dBeXpHejRq?=
 =?iso-2022-jp?B?ZkY2ZWNNNi9JblpqZTBzeDYyOFE5VkthUEdXYkNCMlNwS2dIR1ZiL0hB?=
 =?iso-2022-jp?B?NUlXcTNKK2MvbTR2SzJETnNVNVFTTzF1RFN3cHBjOHlseWI3NDVNVlla?=
 =?iso-2022-jp?B?VUhGYnVLdGJaY3RMb1Z1eXpmK3EvK3IzRThvVjNtNW4xeVJTd3JzN0p2?=
 =?iso-2022-jp?B?VVdDYkx1UUlMeVJzeDZkQ2xIUndRUFFIMTF3UkhlcjJLWEVLcUlIZHc2?=
 =?iso-2022-jp?B?N2tpOGVTdGxUUWV5RWtJaGxaVm5HZTEzd1ZMdEdvR0pmeTBjRmFOTWRK?=
 =?iso-2022-jp?B?bFhOWEtMY2FQS2xMYXEybWJaT0QwT3ZXc3lvOEhoOTl4NW5USVhiZ0Zz?=
 =?iso-2022-jp?B?dkRqa3lGMlpwQlZzZWhxaTNRMEZqMkNBUS90dzQ3L24zazc2QUxJQjlO?=
 =?iso-2022-jp?B?VUV4RU9DWnd4UlVyeDZ6QnN2bnBmTys1bi9vSkZSdmNMUzlkZGV3M1dz?=
 =?iso-2022-jp?B?RHFtTUFLbW44M0ZzSVFnaUFqRS80d3RPb3N4VzcxYjRxU3VxOG4vQmo4?=
 =?iso-2022-jp?B?T2hMalVZNDk1dnIzTkZDL3RMc1NPU0tzclh1Y1BnU2tsZGV1eTJ1YWl4?=
 =?iso-2022-jp?B?ZS83WjZzdFE3YVdqTy9pUGgwd2hnQU55bEhFbHBPM01Rc2p6M3lNY1dH?=
 =?iso-2022-jp?B?ZVIrRUV2bkxUYVg4TWtucHV6LzZ2SjhZcUVMR000TnQ2dlpZeWpaRzFk?=
 =?iso-2022-jp?B?MjBidi9LSVlkeE0rUTcwb1V5Z1VGWHJNY1FmREY2TkNrcjIwWEZjc3kr?=
 =?iso-2022-jp?B?RDgrR05wQk5ydUU1bUhZT1U4NnpGK1hWbC9QRWc0NFFZS2RnWVJOYzNY?=
 =?iso-2022-jp?B?MUdMMnZ5STVhVlgyWDRyaVI1Tk1PQUlzY0VlU05BUWpuVVkxU3VoMVlO?=
 =?iso-2022-jp?B?cEdISk9VU1NoelRoZXQvY1BNd0M3M3R2cG1xZFYrVFRPR1RwWms3c2JZ?=
 =?iso-2022-jp?B?dG1tRWI3Y3ljWXNIdk13bFN4dWxoYk0zN0E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB5896.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ba43b6-f9f8-41b0-a40c-08dd5d523943
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 08:29:48.5793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ERVZeT+v7LMrH8YE29S5U2Cp4Tr5T8CQDUFvfRtm/VhXedxMyIxF8DzPgcJ7fCyz679NE88B7sLuy0477jawHK97dwtm8aZ7PbuL4wGfvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15275
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Mar 2025 08:29:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18068

Hello Shivanand,

> From: Shivanand.Kunijadar@toshiba-tsip.com <Shivanand.Kunijadar@toshiba-
> tsip.com>
> Sent: 07 March 2025 07:05
>=20
> Dear Chris,
>=20
>=20
>=20
> I hope you are doing good.
>=20
>=20
>=20
> This is regarding the improve test coverage for swupdate and secure boot
> activity[1].
>=20
> We have a scenario where we need to verify the secure boot with mismatche=
d
> keys, for this we plan to use trixie version of OVMF keys to verify the
> bookworm secure boot image.
>=20
> It is working locally and throwing an error =1B$B!H=1B(BAccess denied=1B$=
B!I=1B(B as expected.
>=20
>=20
>=20
> So, it would be better if we add trixie OVMF keys in any one of the lava
> slave machine for this test scenario. We can use tag option to force the
> job the to use the specific lava slave machine for this purpose.
>=20
>=20
>=20
> And also the zchunk based swupdate is only supported in trixie version as
> of now so, in order to verify zchunk based swupdate on amd64, the trixie
> OVMF keys needs to be present in the lava slave machine.
>=20
>=20
>=20
> If we add trixie OVMF keys to any one of the lava slave machine that
> device can be used for these two scenarios. What do you think ?

Our LAVA workers all run the same Docker container provided by our fork of =
lava-docker[2].
So, if you add your keys as part of the lava-slave dockerfile[3] then you w=
on't need special tags etc. - all workers would have what you need.

One potential issue - are you adding private keys?
If yes, would it be an issue if they are made public within our lava-docker=
?
If it is, we'll have to think of another way to keep them private.


[2] https://gitlab.com/cip-project/cip-testing/lava-docker
[3] https://gitlab.com/cip-project/cip-testing/lava-docker/-/blob/cip-lava-=
docker/lava-slave/Dockerfile

>=20
> Please let me know if you have any other idea.
>=20
>=20
>=20
> Please note that we don=1B$B!G=1B(Bt need install trixie version of OVMF =
package,
> just adding below two files in slave machine is sufficient.
>=20
> OVMF_CODE_4M.snakeoil.fd
>=20
> OVMF_VARS_4M.snakeoil.fd
>=20
>=20
>=20
> If this approach is okay then I will send these files in email.

Please could you create a merge request [4] instead?

[4] https://gitlab.com/cip-project/cip-testing/lava-docker/-/merge_requests=
/new

Kind regards, Chris

>=20
>=20
>=20
> [1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/120
> <https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/120>
>=20
>=20
>=20
> Thanks  & Regards
>=20
> Shivanand K


