Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF86C5B543
	for <webhook@archiver.kernel.org>; Wed,  4 Jun 2025 08:28:08 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.11322.1749025684152222350
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Jun 2025 01:28:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=AF71zCBA;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1749025671;x=1750235271;bh=BKJcB242hJo5dTwk7SwDM5I/Vm0Tzu04p3NbW6X
	hnoo=;b=AF71zCBAUfgI9lw6JFbj5/AGiMLUJncKK+WRmd3bNB6x1yTLGXQVPmYG0hoBXDAArcdEx
	N6EAS3HbEryF4cYhG/KaUgDYZhQ9v2Avv3SdR6At2TGdlKMXX+IgcWMLI7rRd3J17p6+Vdi+bvH7S
	bIQrKNCvGm9xynkjAS/jjP2hWz+p1CyKo/kN+2Jj/XadEzNaRFGReFCnFk9XG/aJZUZvPcsiddLKY
	7F0a1kH40LqAyhNdI69o+EQSWvuFcI5jvw7PpDijp2CHMncwWBFYPeJMMYew+cOUCtYVUotUryXiJ
	K+Nc8apY9jnSGxmb2xExAp7+PZz0p4/WYFJL6B6OlA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 5548RpRr1799626; Wed, 4 Jun 2025 17:27:51 +0900
X-Iguazu-Qid: 2yAbG2MEHqsu6UN8tm
X-Iguazu-QSIG: v=2; s=0; t=1749025670; q=2yAbG2MEHqsu6UN8tm; m=hoI3TccoqxPCmjlZPgXLuj5vm1awyAWAr838j9fpibI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 5548Rnv3196381
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 4 Jun 2025 17:27:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oaGKF8sGQDpaBxqlQSOv9Obu0UyZPLen3KMBhvLyWjnYMdkCFA/wmTO32/dHiQcO+Ac8xOWHmmmbHOduEERtpLo7GPV8XW3pYlqeIRHqqHHZMT9ylJ0fRoD4pxMJj2mnl28yiB10ud4aA3OKY4MsD6uCEBF1oiKPFU7CmWAGlwbmIaMB9ujJWlEh1ctgXY2Xie51838TXQhe+bOnJHgHtkUIQ4dK7jReEZqPjtDBdQTh1CkPH30VwiicHWeWBqgb8Kd94zWjvDIQtn+v3vsdLPRaAeHqSLf2I5iKrKg/D5Fyc56cvjyRzePxUYxw5LiQWVhJMVv5+cEVsmE/+QYoxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tswMGMKbuKi3wTFbVSLtmmqx+qe2GWLGmqW7LihAoQ4=;
 b=rjcldlNvIEwyi3xTmQLx/7odo0rnx/7IdTwa7tp54MFYHNCqxBRwvifw8BdNnLyqAzF0WKfCiTteD7zM+F2oZ562PcLLS+GR+GL4IO0c7dW6K6axzKILhA2BTw1ttwQUrqvKftmyj6+APo5gI18SxvOK0JRtj+v8WEwolBLDM9mAW3YyqbzliemdQxyc+YJ2vynIB66Ti0t/tVFwpBNz0Z0pHNXqBNeZHJEPIV8lsbJrOnDy4TlJcP1zK9kRZ6pyNCGIbZBIyij9WYcbt5qJSoxW85SmKPCYJPGBXtd4aQxD8bmrOwgfjcMXpDxnn0OwzxIWGZgz5fbKJWpV5ZERJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <claudiu.beznea@tuxon.dev>
CC: <cip-dev@lists.cip-project.org>, <pavel@denx.de>
Subject: RE: [PATCH 6.1.y-cip 0/8] RZ/G3S: Backport SCIF support
Thread-Topic: [PATCH 6.1.y-cip 0/8] RZ/G3S: Backport SCIF support
Thread-Index: AQHb1GipN1cO6uv4Jk6AKTwQmigop7PyhYGQgAAlS2A=
Date: Wed, 4 Jun 2025 08:27:47 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148184237F8FF84BEAA62DC62926CA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250603091940.3917581-1-claudiu.beznea.uj@bp.renesas.com>
 <TY7PR01MB1481886E2F4073789E4561908926CA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY7PR01MB1481886E2F4073789E4561908926CA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYAPR01MB5658:EE_
x-ms-office365-filtering-correlation-id: a1b6a813-778d-43f7-3b88-08dda341afed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?VTEzblE5ZnV6VEFSOXZzT3g2VnVVeVJtNTRIKzNENm9kbTFZamJ2N0tU?=
 =?iso-2022-jp?B?MUo3Vktna2pXQmE2RFNidGw3ZzFvZ1NhUC95Q0RoZDJvcnBzdktXQzZ2?=
 =?iso-2022-jp?B?enFoTE5kYmJwaVc0Qkp3NEFnRng1ajlCb0tldDM2WmZrdERxREVmeElG?=
 =?iso-2022-jp?B?Rk5iNC9oeVlQOWYrMzdCSDVCRUw5dFgycEhjNHFENTFkUkRCTUJ3dzNI?=
 =?iso-2022-jp?B?anJSdFcrZEc0Smp2TGZQaUQ2aUpnazFwL1MzVVdHS21YdklsSTYveC9p?=
 =?iso-2022-jp?B?TS8xWDZKYk5OOVVaVFBwZXRwQ0FiRjVQZXNSR0JNKzE5SDVZUE9ZY3BT?=
 =?iso-2022-jp?B?cTgrdWhvUmt3T1I4N2VaSlRlYlhpWGJZRzVCNkE1ZU5zam5SZTZtcmM2?=
 =?iso-2022-jp?B?NU0rRkNlUmFneEFKZ3R4YlcxSlN3VFo0ZVpiOHJhLzJvVXltQmlhV0hy?=
 =?iso-2022-jp?B?YlJYc25MTXl6amdoeGNUckJXWTVkS3BFL29sbkU3YjBGb3JYUk9NdWxV?=
 =?iso-2022-jp?B?NUxTSkZ1WVV6OG5zaXVMa2o0bnlrTWJqcXVJdzdScXY5dGtWS0lSNkdr?=
 =?iso-2022-jp?B?QXZpR2U0SmpCQzRhUi8xSkFFdzE1dFU5cWNDNUhIZ1NGcGVlY1VpN0Vo?=
 =?iso-2022-jp?B?TnZyQU93RDZsdm5rM3R5MFlTbm9vQnY2RTE0em1WcU81Z3hWZVRBQ242?=
 =?iso-2022-jp?B?TGNxRVBocmtEdTI1TzBXbnNXdUNVcGVaWk5BMDVQVFdvYTltUjRKNVFO?=
 =?iso-2022-jp?B?SG02QzRUYm85QTZrZExURkZXeDlzWU13N3lucDg1cmltRUlqRHd3UlBw?=
 =?iso-2022-jp?B?ZXNybEk1YUhPN3doc0pGdDVmMVpnMjlTWGM4QmdaUGdzNk1sSVdWZlJt?=
 =?iso-2022-jp?B?NlIwTS82MndEdVNFeEc2eHpoYTR2OVdJOWtMVmlGTnBoSUZhNnJBUjVF?=
 =?iso-2022-jp?B?bXYyK25oeE1kWlYvcVBSenVSTWFGVXVIekYzQkVTZElYV2UraDhhZU9U?=
 =?iso-2022-jp?B?bitwaUE3emtBcWFjN1U4Y25KN0o3di9sSWRqeTlVU2NkdndJZ1FDVWVU?=
 =?iso-2022-jp?B?eGdHcmdoWUE1MGU0c2RDNDExSU80T2gweDc5MENYOTdQaWZQaWRRVTk2?=
 =?iso-2022-jp?B?eXJzQ3QyOVFiMzRVYWhjOFVVcGRsckp0Y3hTcFUyRkhmSlh2a3VIRjk1?=
 =?iso-2022-jp?B?NEVONUs5VWdRZ0d1NDB4Qnlaa29UNENpN0k3SGx4Y25CN3RvZXU0OTZ3?=
 =?iso-2022-jp?B?YmM2blJqNTlNeW9EZDlmRXpHcSt0S3pyRG9IaGRVYk5YOGdzZERVUmdN?=
 =?iso-2022-jp?B?bXpVVkVzdHM5K3VESis0VTl3NjlyRGFPcGxlNW1CQnBoQm9KKzZ6YWtF?=
 =?iso-2022-jp?B?SHVPQ0tYZ25COGU0RFd3bGZLQ1NodEhKMnV0eDNqdUtsWFd0cXNzSHJz?=
 =?iso-2022-jp?B?ZCthOUJDUitDbVVZMjgwZ1NOWk1Rb0l5QVVGMGh0ZjBUMjgrQ0lRUTJS?=
 =?iso-2022-jp?B?YnpreFExUXlLN1NxbURhZm9aN0VaSHlZazRUZ2JXMVRhWHBSQjNVcUl2?=
 =?iso-2022-jp?B?Z0NxdEJ0STdua2Q4VXppREMvOTJ5U0RqaVRTVG9lWm1hSHdxdjZMWHhW?=
 =?iso-2022-jp?B?ZVprR2h3OFBUNnc0R0Q5djB4cWNUMXVwWFRJelFzUVY3M1FCam4rdmdS?=
 =?iso-2022-jp?B?MzFRMnZZUmZ0cUhFaTRLVGFObUc3ZzFFT2V2YVkvYUhSUjlWZEptMDJr?=
 =?iso-2022-jp?B?aElma2VyUENKVFdzZVNHc2MwcXdoZ081ZTM0WW9oSXd5d0l2WFZkUERY?=
 =?iso-2022-jp?B?SUtyaHRJbDF0SklhS0ZmS3hlOTBYY2RiSUpRUC9vTkFJSWlxSVoyTGdQ?=
 =?iso-2022-jp?B?WGROVm5iMTdnelBDUzZNT2NNQXJ3TmlDSTU2ck00MlVuMUVYYkpiN3dQ?=
 =?iso-2022-jp?B?SFhZdlFvWklPeXIrT1hseldYZ0s4ZzFRSHpLdUVVQ2hxaldZYUlzbG4y?=
 =?iso-2022-jp?B?a3hoN2UvQ3VCbGtuU2kwY0s1QmthY2IrdXYyeEx3TUZaak9YNWVQNWRF?=
 =?iso-2022-jp?B?UTdOYnJTZ3dsV24yOFBZelhLTm5UR0E9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?aTR6SjVsSnU3djFJbWJqdkJwVEhzRHZERTZ6ek00YXQ4V1NFamY1c1M4?=
 =?iso-2022-jp?B?Q3k5YmxyMk5WVHpydHhuWjBISmZ6MWtKbERjellGM0RDRytjalVhY0Vv?=
 =?iso-2022-jp?B?cm1kZGtwcGpzRGZFT1NZK2FoVDNtV0tmUnVFdnE4R1lNMFFZM0N5bG52?=
 =?iso-2022-jp?B?LzMzZWpuTzloOG1WV0NLbzFwaC9hcVN2V0liaEZSay9xMXlxTndwVHdW?=
 =?iso-2022-jp?B?MDA2Ym1MbVNRa0RDWmM3YjZsNHhWTEJVRndRdjZpOTFHckUzT3NaSXg1?=
 =?iso-2022-jp?B?NFNIV2NmSGRLQTdoYUdjQ1VGSlNnZWhDa0RadXFDZkZ1NHY0K2MwNkdU?=
 =?iso-2022-jp?B?UlE2TFRYTlNYK3RFWmlXSnJWTjZaWCs3VHpFcExoU1BqTjFSS24wV1FS?=
 =?iso-2022-jp?B?VWd6aEt0aDBmbFc2Y2FPNzFVY2RzWHlFMlVKMy9UdzAvTEppcU1MNm16?=
 =?iso-2022-jp?B?UmpWaElKYVFjQm9DcS9HL2ZMSmkwQmFFYk9RQml1cTQvYmRiVHI0TVMw?=
 =?iso-2022-jp?B?UEpoY0VFU2JOZ1djYnBVYmhuQzFUcXBFQUxwOXA3VXZkYkF5TlBsdXRa?=
 =?iso-2022-jp?B?Zjd3ZTJVdG8rUkR3SjNhUU5mUVYvb25kMzVoZlZESW02MGMzZkhXSjRh?=
 =?iso-2022-jp?B?OThhelJtM2lyRytXaHVvMVJzU2tncHdEMUppNVQ2dVpxSkxob09yMUpl?=
 =?iso-2022-jp?B?L29jZFNOZXdhZlQzMm9VSWN4SlNOcHVkSGt5aHRPMC9jRkZlend6OThU?=
 =?iso-2022-jp?B?Y2M2aFFiKzJCYlFhY2ZTOXpRcTA2MmllR3F6c0t5Z1ozaXh6ZVBMelU2?=
 =?iso-2022-jp?B?YzhVM3ZlL3RaQmg0OVliOVltL1dNOWNjaEh2eUtIbTg4aysxdGlXMTdo?=
 =?iso-2022-jp?B?bmgvSFlQVkZZMEFOS3prNzNiQnpMNU93WkRPNExqY3F2cmw2K24xcG5Z?=
 =?iso-2022-jp?B?b09sZC9kWHdxNnFCWG5hdHdpdVdzUVduSzRIOFlUeWJGMDBWMHVHdnNT?=
 =?iso-2022-jp?B?ZXVFMlR3eWxVZEljQnh6ODdCN2p6M0lRNlBjemRvMHErQ0xvNmFIR0ZU?=
 =?iso-2022-jp?B?cWNidkxRKzB0SGxBQmxBRFlIMU5DMlZtaTc0aFNDeWpaR3g1QWZ5Yk0z?=
 =?iso-2022-jp?B?UmdycEVOenBML1lTc2hxVEgydnAwa1ZGRk9SdlJEUktCWUlZNktGaGI3?=
 =?iso-2022-jp?B?QndoOFM5em4wVUlIZ2tZem5OUFBGeXdUVUdPN2t4a3AwRG5lOCszYkQx?=
 =?iso-2022-jp?B?RHlNQ0pNblZobXRxL0E3cjM2S1J6aklmVGttcXVXOXI1SXJrd05xNk5N?=
 =?iso-2022-jp?B?blhWS0RtMGtyMi93MDBFUk5YUXhOb3lCM3NHU3pGSlJBU0duaXJEVmIw?=
 =?iso-2022-jp?B?SjdBLzh0QnFWSkU4b2lsOUpXMHNCT0EyaVZLMEluc1Y1cVRYVk5xWFMy?=
 =?iso-2022-jp?B?Q2xjaTRWZEJ4Mm1vYmJ2ZGlWcjdvaFFUTk4xblRzd3M5N2JrQlpyZFlh?=
 =?iso-2022-jp?B?VE9IYXAzZ3pOMGtuRkdMUngyUDRHcW9sQ0FkL1VCZXl6eTBJZHpSUWJa?=
 =?iso-2022-jp?B?cUMyMGFNQTcrVE16bGY3VVpWTzFiVGkvU1l5ZEsvclJiVSs5RklTTTFn?=
 =?iso-2022-jp?B?amN6MWVFYUlnWUxQd0w1djJ0aElpSDJsZU0rMDJtaUozVFdUWnJQT09s?=
 =?iso-2022-jp?B?SURXdHRVV2tKOWVlSVlybHR5TGV0bm1lVVQ0Ym5IVlRhay9CdllOb3Zy?=
 =?iso-2022-jp?B?V0NLTDE5T25ManhvbHBTSU5zQjMzZ2cyMVAzMG43dmFEMklLOUpSaTE0?=
 =?iso-2022-jp?B?WEd3K1huL2NCYThtZkNBWVB0bjZJTlNlS3lOMG9UcEFQTklCZlZzdFhB?=
 =?iso-2022-jp?B?RjQ0dElMOWJQR0tBNHFpZTRGMUM3MGErM3pZYTZMRjl6UXdYMmJ3RkdT?=
 =?iso-2022-jp?B?emd3NjVZRFBZdVpHUDRxNUVFREdFRGxKblRYa3drRzRFZ2RlNXE0SkFq?=
 =?iso-2022-jp?B?cWdQTVVYZ1ZFY3NvOXJZQ3dpdVI4a3NkUW1HYmZFaytzYUpESHNOQ3VY?=
 =?iso-2022-jp?B?cWxSOS9YUEJPV1pmSzk1N1hsV1JsN0xuK2NIN0xtTkRlMFVLemFrMGNB?=
 =?iso-2022-jp?B?WjlPM2dhZlh6a3ZlaStDYWE3Vngyb3RidW9wemlRM2tNVEthNEZKRlNZ?=
 =?iso-2022-jp?B?TXRpYmpOME04K09qczhOM3BIVE1oNXhzK3A5QzVCL0xZK0RhZ3FDSVlE?=
 =?iso-2022-jp?B?SVlUbHVvZTNXUTBiZ001WEEyK0pJL2k2TW4rR0t2Q0xDekRsc3EvZTlm?=
 =?iso-2022-jp?B?WmhGSVNtUXJPb3A0NkRtZEFxQ1UrM0trc3c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b6a813-778d-43f7-3b88-08dda341afed
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 08:27:47.5699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /+fDqKsu7qpOjUy+t6sFMUa2iOZaUyIzI1XnFJXFxQj23qM0ybfsv4AWV2YfrYgteDdd1ZdkDVQqcz2YOnm/HR5n3muz1ArG8G8PWWB8GFlHMCPyoCsXHjhe/u/I3QOT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5658
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jun 2025 08:28:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18999

Hi Claudiu,

> > Claudiu Beznea (7):
> >   clk: renesas: r9a08g045: Add clock, reset and power domain for the
> >     remaining SCIFs

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/10246798017#L883=
4

The build fails with this patch. It cannot create dtbo from dtso file. The =
filename of r9a08g045s33-smarc-pmod1-type-3a.dtso needs to changed to
r9a08g045s33-smarc-pmod1-type-3a.dts.

Best regards,
  Nobuhiro

> -----Original Message-----
> From: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C=
#P#T=1B(B)
> Sent: Wednesday, June 4, 2025 3:10 PM
> To: Claudiu <claudiu.beznea@tuxon.dev>; pavel@denx.de
> Cc: cip-dev@lists.cip-project.org
> Subject: RE: [PATCH 6.1.y-cip 0/8] RZ/G3S: Backport SCIF support
>=20
> HI all,
>=20
> > -----Original Message-----
> > From: Claudiu <claudiu.beznea@tuxon.dev>
> > Sent: Tuesday, June 3, 2025 6:20 PM
> > To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C=
#P#T=1B(B)
> > <nobuhiro1.iwamatsu@toshiba.co.jp>; pavel@denx.de
> > Cc: claudiu.beznea@tuxon.dev; cip-dev@lists.cip-project.org
> > Subject: [PATCH 6.1.y-cip 0/8] RZ/G3S: Backport SCIF support
> >
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > Hi,
> >
> > Series backports the Renesas RZ/G3S SCIF support to v6.1.y CIP.
> >
> > Thank you,
> > Claudiu Beznea
> >
> > Claudiu Beznea (7):
> >   clk: renesas: r9a08g045: Add clock, reset and power domain for the
> >     remaining SCIFs
> >   serial: sh-sci: Update the suspend/resume support
> >   arm64: dts: renesas: r9a08g045: Add the remaining SCIF interfaces
> >   arm64: dts: renesas: rzg3s-smarc: Fix the debug serial alias
> >   arm64: dts: renesas: rzg3s-smarc-switches: Add a header to describe
> >     different switches
> >   arm64: dts: renesas: rzg3s-smarc: Enable SCIF3
> >   arm64: dts: renesas: r9a08g045s33-smarc-pmod: Add overlay for SCIF1
> >
> > Geert Uytterhoeven (1):
> >   serial: sh-sci: Save and restore more registers
> >
> >  arch/arm64/boot/dts/renesas/Makefile          |  3 +
> >  arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 90
> > +++++++++++++++++
> >  .../r9a08g045s33-smarc-pmod1-type-3a.dtso     | 48 ++++++++++
> >  .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 25 +----
> >  .../boot/dts/renesas/rzg3s-smarc-switches.h   | 40 ++++++++
> >  arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  | 20 +++-
> >  drivers/clk/renesas/r9a08g045-cpg.c           | 10 ++
> >  drivers/tty/serial/sh-sci.c                   | 96
> > ++++++++++++++++++-
> >  8 files changed, 305 insertions(+), 27 deletions(-)  create mode
> > 100644
> > arch/arm64/boot/dts/renesas/r9a08g045s33-smarc-pmod1-type-3a.dtso
> >  create mode 100644
> arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h
>=20
> I reviewed this series, looks good to me.
> I can apply these, if there are no other comments.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>=20
> Test:
>=20
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/185234969=
7
>=20
> Best regards,
>   Nobuhiro


