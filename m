Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D33CC41513
	for <webhook@archiver.kernel.org>; Fri,  3 May 2024 11:47:28 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.71])
 by mx.groups.io with SMTP id smtpd.web11.9996.1714734423784642467
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 May 2024 04:07:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=QV+70T9k;
 spf=pass (domain: siemens.com, ip: 40.107.22.71, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Glry4Fr+EwRcDVgXYlSK5Kvpw+JAbBDwuaIfhzEFJPsNbjsitp13MteA4+4x3iCM92pJEnqBBtc28OvBBHrI9onJpmOXFrcYCd3KOdl4OK1O6SY0qEL6zZRrRNob46JQQDd8j/KxQvNvWgsTaTDZjAR+u/I7hYft20TQ/y4ZrYnuPN9SOf5jb0rzSA3gxtpDk+Wsd5KKFujnnII5vWmVKmwM5SzA69JZ6X6fdrShIJPoPGzYm2UoTfEW7iDwmveXm2a7qR5ZKQnIQfAWxPRN3SgKJrT4kbrItcGb5nY5nK15CGuEXTfKHVflfHIaMSnRiXWwK1UkhUus7cg0fUBseQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=im4wn+mLulkdOEPPKRShViO5iv2MH4Fv3D+7y4qRrms=;
 b=Bu+I84l2eeLXzbJTSwkN03HHMp7uOwDuau5MISLBX/qJNvbSq0bB5CvSGQmK2FF9VMIUk69Fy8xzC2Mo7TQTs19jvjlcvPix5IfpC86JENn/ddFJvNlvuxD6rLwaJ3swUmk0OwyTH/ijrelqgvM5Spbf0456qVSUL7fxuPKx1RDrba4YKhd44I7ZSAW/dN138Eg4zK0BWKdYZ/G3p2uJ0Xa1Rd3IF5Dfz8xPybVochSikaH+HDFryYvbjT9PIqYJW7zVHeZDXSgR+Ubu10EDZomAWqkIxk5lveUcDDOwlA24ZF2Bw1+42aWDQY995m+v/cxJjx/qoi8W1zHPj4Nkig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=im4wn+mLulkdOEPPKRShViO5iv2MH4Fv3D+7y4qRrms=;
 b=QV+70T9kQxP0wEPGXGdAoPNon6mzHfus6Z0zgeRagNPzfOM2gfHy+UqltEitDhw1iA8I5lXZyIuQiWi/2gQm23l4X1zjAyahqTLSitumMAMMat1veTJxRyw0YB+Cx+VPQ1uw5vUCuPgEKy9xa3fgnr1AP4rBXI7UXJBWxm25PpXxUeSuheXcZEwPPHezsYU9AppMrBK6Pv28U4feUHUXyBPwe8jeIoJs5z4v6h8MqmmOugOf45bXMifAVwiYjflhsnVrmKWNBv6IRALDoVuDAWmEHh0hE4mqKbS9tlWXkwqSyeW4cBG5BMaWbAEgY0K65y+Ij7xmKmUMvDMD3XQlWA==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by VI1PR10MB3614.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 11:07:00 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 11:07:00 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "johnxw@amazon.com" <johnxw@amazon.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH v4 2/9] initramfs: allow empty mountpoint for crypt hooks
Thread-Topic: [cip-dev][isar-cip-core][PATCH v4 2/9] initramfs: allow empty
 mountpoint for crypt hooks
Thread-Index: AQHanHOwwWuvf8X0pk+7d8Obd+YpfrGFWyGA
Date: Fri, 3 May 2024 11:07:00 +0000
Message-ID: <47b9ed63940c6b8947fab4e066fab4f32affe720.camel@siemens.com>
References: <20240502093240.364093-1-Quirin.Gylstorff@siemens.com>
	 <20240502093240.364093-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240502093240.364093-3-Quirin.Gylstorff@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|VI1PR10MB3614:EE_
x-ms-office365-filtering-correlation-id: e9ea2a1c-1ad7-4ec0-d5bc-08dc6b612817
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cEhQWnV6VmlqRVNnWmlZNU9PY3U5bGZYbERqVEZsYUtUWE5xS3FvUUk0RFBF?=
 =?utf-8?B?NGFkVVRuR2JJQ3hMZmh2a1lid0IvTCsyZzBrTnl1ZFNmTUVEVGc1T3pWM3NC?=
 =?utf-8?B?T2tFT3MwNFFRNzJxelBhZVNDMy9YWjJaYmF3dDNiTU5TOU1TYksxWWRuMDJa?=
 =?utf-8?B?SnJscnlYSEVaZzFMbE9WWG82aUsvWmtvR29HeXhWL2lXcUoxSzRnUkRKWklw?=
 =?utf-8?B?YWRubVVDTmIrUU5ZL2Irb0xEZ0hKWXVPRGJVc09ONk55QVRxMktKMlVZMHFV?=
 =?utf-8?B?cWRIZm4xeXBQN2lENnR6SmlJU05acjNrb0NPMi9JdlVOYllrUCtmeGp3VUln?=
 =?utf-8?B?UU1aaXc2VTRiWE9MR1JoSmo5VHZubW1EOW5PNUZPNDFvM1NyRlMyaHp2THhm?=
 =?utf-8?B?d1IxNExtVHM0S2hhQ2c5N1RMWURuckc0Zkl1cCtuaU1qZEgwVHZTclVtOXh4?=
 =?utf-8?B?UWFOMFZHd0lscmxnRkpSN0RqTWxBcjBNZGJ1eUxhRHB4aEEvc0xRRXBBWEtU?=
 =?utf-8?B?YW5OUElvcUpvRGVpeGszc01KcHVHQWRwNWlKUEEydWtNOXFUOFp1WjNKRE5N?=
 =?utf-8?B?UzVwaWJmT2ZMNlc1SVQ1bVo2V1RSN0R1dk11a3d3em5MKyt0VXlWWkwzeWQ2?=
 =?utf-8?B?WXhXMmZMb1MzM1RaOHBuRGFaR0tkTGNLMjExcmNIVmJzNWtYMHpVM1YwNTBX?=
 =?utf-8?B?YWVCcjI4MmdCNWNuQllSYjQ2R3c1RmN6ZmRQVjFTYnhhRkNIaHU3TmVGemN2?=
 =?utf-8?B?cUs0TW5pOGtQQXpqM2x3bjRubStmOFRYakVDeXJlNW5ZSjN2U2dHMmo1RmNF?=
 =?utf-8?B?dGRxNExVeURRcnJvNG5jMjY1QnVhWXFOaUVSd1NHdFlhbHFIb0loZEs3MG9M?=
 =?utf-8?B?SzVFRXZ0OVp4Skh1MkF4eVIzc3Jsb1VVTzMvMStWVWxhakVuVnF0bS9qa1Yr?=
 =?utf-8?B?KzNaV0FyWWprbFFmTExvSnFnWndZK0gvUm9qNkhiTGlWOXdGS0JIUk5NMUlt?=
 =?utf-8?B?V1NMUWJpZGV0R2x5VDVQL2NZc0Z2c09IRUd1akh4dFVTM2hERGovZEE4WWoz?=
 =?utf-8?B?VG5lNER3dTh5YUZ5VzZZZEZmcmNpdGlZT0JFNHlpVW5Kd2VBQmZGNW9wV1Yx?=
 =?utf-8?B?d3RsYWJwaksxYTJLM3QrRGdMMm5WWHZiY2RWejRFVGtUREM0ZjQ2K0dWelZV?=
 =?utf-8?B?dmQyckNJNjN5dS84U3NJQ0JRdUdaeGl6eWdOekR0YndSamdxMitZWUtjS1Nu?=
 =?utf-8?B?WFJmdnVVdTlyWnIxZGdlU2pvVVhPTEpVZWVma0FxeUJpcng2N1YzQzlqVG14?=
 =?utf-8?B?bnRNZjBOTFJrSlZkT29rR01ZVlJXc3ovZGdUOU5WYkIzNWg4K1JLRlV6YVc5?=
 =?utf-8?B?bmUxRFRvMGlUZFhwMmtNeEtZdGtVcFg5Yi9uSC9scXF0UzlxNW9xSzUwQkFn?=
 =?utf-8?B?L0twVjEyOWNRd1ZyYkhoSk43RTZjNlNuRDVFTHhyRUZSY2UvR1lpalZtVkdY?=
 =?utf-8?B?L0RibG9vdFNJM3dSd2ZIcEY1cGdPOHY4ZG1QODY5YVFRRkRFREpOKzJ3M3lW?=
 =?utf-8?B?TGNjMjRGbktYMFgvd2Zkd2JIanRTY0hJRlByalVtSFFOaGdrNE5vTytCL1BI?=
 =?utf-8?B?UHk1Ui9KdGU5YnprbTZsRU5hYWMvdGtVS2k5Rk1xZWZITU5zYzQ2a284Z0sy?=
 =?utf-8?B?YXJZeEVoeHlLaUZJOHBsQi85WmhKWWZoNzRUek1qbnZ6MXp2Mm1JTU5rK2xS?=
 =?utf-8?B?RW5DWFFXVjkydTB2N2JORHkraExTMUF6UGc3WkZzM1J6Z0dzcWF4QnRMV3dh?=
 =?utf-8?B?Wno3ODhzdHFIdjRDb1oyQT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dWozU01vcmpkN1AxWDJkeW1VRDlFTWRCV0tGMG1JVnZpOUZYbGs5Z2RQVmlN?=
 =?utf-8?B?MEFyVHEyeW5iWmdaODI3OCtXa1lJa2xmWHpYb0xDaGZBZTEvODUrbjN4YW40?=
 =?utf-8?B?d2FrdUpIMnQyNTFiVGRabm56YVRySUxiT1ErbGl4bVZaYmk5UVpqOGd5bSth?=
 =?utf-8?B?cngxUFlwazJVSDk2MjRycFJGRDBIL2ZhSWRoNVZTZy9vSlhnRXc4T3hPL2NQ?=
 =?utf-8?B?K3ppZDZYaSttTWVFM2JzNWtIdzV0MGdWaXRFMWZyK3pXZGh4K3RvTmU5bjls?=
 =?utf-8?B?eTJmMnE2NUl2NHZHb3VNUk5jRGxkSTV1RXY2eVJpUUYxd0R1eFlMVkg0YWQ2?=
 =?utf-8?B?U2NsekJsbyszQ2ErWVh1YWlXM2dMdVk5cTBBS01QYjB0R0hqcVV3THJid0FP?=
 =?utf-8?B?Rmw1TmxJRlIxd1JHZlJKdHBsTEhvRGVuZzFvclM3eDJ6bmhITkNweEEyVEtq?=
 =?utf-8?B?d0UxYnBkSDhwRUdTS0xqQUUwdW54Q2JkdTllVmNIUWJGeWhQN1NjT2Ntc25j?=
 =?utf-8?B?V2dFbUNEZkpPR0Q3aXZIRGc1bGVyWGFaQkRMbHltYXhtKzF5bzVJSjFGWHF0?=
 =?utf-8?B?REZNZllWS25xeUhKSnZJMXFNZXpWQ0VPaVVoV2JzUmQ1VmQ1YjhWUE9PcFFv?=
 =?utf-8?B?Y1NtdUdDeDgzbDUzYjFFQXZLREpjZktvMFlmQ1c0UTh3TjlNMi9MV3BGeE1z?=
 =?utf-8?B?MCtpODBnU0dick81S0ZiMHJvbm05QmJ4YmZpOExnd2xBL1NOK0lGeVJsc1pL?=
 =?utf-8?B?dFJnSEFMQk05M2NNNXQwWktKejdZUUhrY1BiWFZLbUdTR2tiYTVRclJJbFhy?=
 =?utf-8?B?SUdzWGdxQnhzN0RaL1Z3UFlsM0krckNvRWNYNzJlWGZvMUJhU0o1eVY4aUtP?=
 =?utf-8?B?SndBd2M0RUNQRGN4VnZtMzNnQVc1SGtrdVdORVJscWtyd3BhNFJuWU0yaVBP?=
 =?utf-8?B?TThncGJLZ2FCVUFaeURJSjZxbjVYWXJGS3h3NDFqOU5qY1lKbVlrajV6eFYx?=
 =?utf-8?B?QVR5VVlOS0JzVWtJZ3FYeXltb1FicHlFNmlRMHpmRFZGTExnVCtNdi9wckY1?=
 =?utf-8?B?ZSswOC9TeUdhL3RQM3VzME9ISWk1Nk5vVFlqYnNyWjhySWIzSEhlK01Jc29o?=
 =?utf-8?B?VjFtcmEvSjlhSndYcm15V2VHUXNlU1BvbXo5cVdnckRMRkFiZHpaTTNYeXZ6?=
 =?utf-8?B?VkpRY1BVdFBDalRsZ1NyRFRPOXhyMkNKWENOMFNyT21NYU1DdlFBRnl1Rmo1?=
 =?utf-8?B?N3VXUmtFbjA5RVRoNktwV01ta2hZZXpFbVVPQXNEdGhDLzBBRUdkTHNVOWx6?=
 =?utf-8?B?ZC92eTFPeVRzTjVkdTRpQklMR2t0QXVHb2FXQ0ljelpHUldGSUtLMXhvUmdD?=
 =?utf-8?B?aVlkTGxoZHd0TXBMRHRiYlZJWUMra3FPa0ZqcEVOWE1zZDIyNXlDUFI1T2lD?=
 =?utf-8?B?a29oUE5nRnUxUUYrVjV5WlcraVVqR0hWN29meUhaTHhzeHRjbmN6UjZ4Z1pY?=
 =?utf-8?B?Sk4yYUx6YzgwTVl2RVBIQldyRnMrb21tUHd3V0g2Uy9JY09LWWNhbHg2NWRP?=
 =?utf-8?B?cTZ5WXZSNXM2MVl4TTRoNm0xY0w5QzdYcy84aFJEY2hqY2NRZGR0elBGUkJh?=
 =?utf-8?B?OFBtNG5vZHgrVVlYVFMyaGl5OGF4eUZNaXhJK25oNzBNdGR2azlMQ3FQQ1pW?=
 =?utf-8?B?MkdUSldkVFZsZzkwbjRhb0pBNW1lRi9rME8xTW5rTVZGMlRJcXFWdHJUcWll?=
 =?utf-8?B?Mk9yOVhERjBTM1Q5WUJYcittZjhkWG9LSWkrbGVDU1d1RjJRWEpURDl4V2hw?=
 =?utf-8?B?OHZ2bUkrdWFWN0tlNkQvd0FIcEFyMHJSbkh1ZFYrWTBndkpRcHBvbE81Z0ZL?=
 =?utf-8?B?QkVwUnBJKzV6NGRoL091cllKN3dRWTA4cVExMWVtOEY2MGlOeGE4ZkVXVXZh?=
 =?utf-8?B?enlaRTVCQ1VRMHZTM2JtYStDUEFPcGFBNWhFcmdCTWpSYXZ0eEhLb09xdWQ2?=
 =?utf-8?B?amFNNXJxb2dpb3QzVXhQbjVZUTc1TTdoZndSU0VtaEwzRDNydFMyRlpXUjln?=
 =?utf-8?B?WmxCUWVMakxTbGIydGM3a1MxOFVNcDVmQlFZK0dQN1l0Mkx2VkVZQS9PcUF6?=
 =?utf-8?B?dHNFZTE3TmQ0QldrYkc2cmNpM2thWERTWEl1Nkt3Z0YzbDBrMDdaR0h3K3dj?=
 =?utf-8?B?Z09OQlU0d0E3VkZmWllZZzR5UEJIVFVJUnNnZktBeUkzREhXV01lQnhmbXRS?=
 =?utf-8?Q?sWj/erIOXyHP2yDw1CL1VJdLsJUyzJ9Tk3Y4EYTptQ=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ea2a1c-1ad7-4ec0-d5bc-08dc6b612817
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 11:07:00.7876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ggaz9gJSoaFkAlJBOzwfyNhBVMMKvnKR+wbX7xQgf9pYewQDFVE7PqmkMSpyOupke2z9G28oWveQbjQYyrtKVJMECwD3rgaHfBu/nqafWJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3614
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <14EE753EADB2ED4890CFB2246DD8D24B@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 May 2024 11:47:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15816

T24gVGh1LCAyMDI0LTA1LTAyIGF0IDExOjMxICswMjAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Og0KPiBGcm9tOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29t
Pg0KPiANCj4gVGhpcyBhbGxvd3MgdG8gZW5jcnlwdCBwYXJ0aXRpb24gd2hpY2ggaGF2ZSBhcyBz
ZXBlcmF0ZSBtb3VudA0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tXiBwYXJ0aXRp
b25zIC1eIGEgc2VwYXJhdGUgLi4uDQoNCkZlbGl4DQoNCj4gc2NyaXB0IGxpa2UgdmVyaXR5IGFu
ZCBhYnJvb3Rmcw0KPiANCj4gU2lnbmVkLW9mZi1ieTogUXVpcmluIEd5bHN0b3JmZiA8cXVpcmlu
Lmd5bHN0b3JmZkBzaWVtZW5zLmNvbT4NCj4gLS0tDQo+IMKgLi4uL2luaXRyYW1mcy1jcnlwdC1o
b29rL2ZpbGVzL21vdW50X2NyeXB0X3BhcnRpdGlvbnMuc2NyaXB0wqAgfCA0DQo+ICsrKy0NCj4g
wqAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLWNyeXB0LQ0KPiBob29rL2Zp
bGVzL21vdW50X2NyeXB0X3BhcnRpdGlvbnMuc2NyaXB0IGIvcmVjaXBlcy0NCj4gaW5pdHJhbWZz
L2luaXRyYW1mcy1jcnlwdC1ob29rL2ZpbGVzL21vdW50X2NyeXB0X3BhcnRpdGlvbnMuc2NyaXB0
DQo+IGluZGV4IDM0MTFlNzAuLmI3MjMyM2YgMTAwNjQ0DQo+IC0tLSBhL3JlY2lwZXMtaW5pdHJh
bWZzL2luaXRyYW1mcy1jcnlwdC0NCj4gaG9vay9maWxlcy9tb3VudF9jcnlwdF9wYXJ0aXRpb25z
LnNjcmlwdA0KPiArKysgYi9yZWNpcGVzLWluaXRyYW1mcy9pbml0cmFtZnMtY3J5cHQtDQo+IGhv
b2svZmlsZXMvbW91bnRfY3J5cHRfcGFydGl0aW9ucy5zY3JpcHQNCj4gQEAgLTUxLDcgKzUxLDkg
QEAgZm9yIHBhcnRpdGlvbl9zZXQgaW4gJHBhcnRpdGlvbl9zZXRzOyBkbw0KPiDCoMKgwqDCoMKg
wqDCoMKgcGFydF9kZXZpY2U9JChyZWFkbGluayAtZiAiJHBhcnRpdGlvbiIpDQo+IMKgwqDCoMKg
wqDCoMKgwqBjcnlwdF9tb3VudF9uYW1lPSJlbmNyeXB0ZWRfJHBhcnRpdGlvbl9sYWJlbCINCj4g
wqDCoMKgwqDCoMKgwqDCoGRlY3J5cHRlZF9wYXJ0PS9kZXYvbWFwcGVyLyIkY3J5cHRfbW91bnRf
bmFtZSINCj4gLQ0KPiArwqDCoMKgwqDCoMKgwqBpZiBbIC16ICIkcGFydGl0aW9uX21vdW50cG9p
bnQiIF07IHRoZW4NCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbnRpbnVlDQo+
ICvCoMKgwqDCoMKgwqDCoGZpDQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAvdXNyL3NiaW4vY3J5cHRz
ZXR1cCBsdWtzRHVtcCAtLWJhdGNoLW1vZGUgIiRwYXJ0X2RldmljZSINCj4gXA0KPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB8IGdyZXAgLXEgImx1a3My
IjsgdGhlbg0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG1vdW50X3BhcnRpdGlv
biAiJGRlY3J5cHRlZF9wYXJ0Ig0KPiAiJHtyb290bW50fSIiJHBhcnRpdGlvbl9tb3VudHBvaW50
Ig0KDQotLSANClNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCkxpbnV4IEV4cGVydCBDZW50ZXINCg0K
DQo=

