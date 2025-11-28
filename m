Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF2ACFD376
	for <webhook@archiver.kernel.org>; Fri, 28 Nov 2025 09:37:28 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12465.1764322645212870743
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Nov 2025 01:37:25 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 5AS9bM62010755; Fri, 28 Nov 2025 18:37:22 +0900
X-Iguazu-Qid: 2rWgRWki9FsLRp9YmH
X-Iguazu-QSIG: v=2; s=0; t=1764322642; q=2rWgRWki9FsLRp9YmH; m=Wt/4zWsg+sO7iUBIHpMa7bhoA3Ng0CjxDdKrDQ0XnDI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dHp9Y6Dx2z4vyh; Fri, 28 Nov 2025 18:37:21 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kr4XT1W206vocJl0G/M3Xq0wGhPjLKYQRV4u2yYuHQAX9rWjwYkrQymAhCmW4fhl60zjxx1ghlMU4gr6yo5j8KCtOLptF9KrAiK0Gnnw41JWEXWIl+iu5aSZHA405S2sl3s0GgbkKco5UA/Lvkf9jh4fqyPcN3QS0cXBXMIm1WZiUYT4qGisKeW1kDfUfBNBwTAkqUEeNr6cuS79Ateejx6kYFL6+9MJZSHow+689Uikq2VXqU2keq8YvYPIQaPVr7VL5CdKxAOXNOMoE8YzkdKimVlNuJRQkSReditylglbp+vzyUfeu7yckBAw/TFJhk87un5tiRzC7GxTtPl+9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eARUCbJgcBZZRqp3psMITjapMzbXblSnrpLF225BnSg=;
 b=FLSImm1z1/AXBMk7tqa/qWx24LxnZ/0jAcKk66DM+iefOlxq+KJvIEBSo+tgVZCSiDH6+Rq0j8YNNdvpjvANgxiKH8T24P/z6NclbDe0MTFEUbiB8Zh3ve6NP4oa/LC2XwhO2oAjMesrQZUfEOmCXsIzbIrgJIPhUoVWucDbF6Sv4k89nS2ifUgpqejScmOu4giOhZFVjJ1YpUsnOyaK8HRYRmE2cTqJyAK6ys0dlgxEjIR3oLwDTI5TLWPcsLhBECCuVvvw8qmPcQfAB4cRZ8guZeOoJPlYU4az338xOL3BUskXudNRxqtFbJBVJzR1EEdnEylE7qsjvCmO0YJvLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <gourav.singh.ext@siemens.com>, <jan.kiszka@siemens.com>,
        <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro.hayashi.f74@mail.toshiba>
Subject: RE: [isar-cip-core][PATCH] fix(security): add libpam-systemd in
 Debian trixie
Thread-Topic: [isar-cip-core][PATCH] fix(security): add libpam-systemd in
 Debian trixie
Thread-Index: AQHcXfvpaLlYrsWecEGOFUyITH/p07UH1RRg
Date: Fri, 28 Nov 2025 09:37:19 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB11075803A132ED49E1CFE0D57C7DCA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
References: <20251124050607.876836-1-gourav.singh.ext@siemens.com>
 <345f8c1e-0166-4946-893b-02dba9dd71ce@siemens.com>
 <KL1PR0601MB4697CEAF6AACC78EAB99E5CBD5D0A@KL1PR0601MB4697.apcprd06.prod.outlook.com>
 <e3ea7e4e-7679-4ddb-9074-fab4f51c8c8a@siemens.com>
 <KL1PR0601MB4697F954236371E6E07F0C35D5D1A@KL1PR0601MB4697.apcprd06.prod.outlook.com>
In-Reply-To: 
 <KL1PR0601MB4697F954236371E6E07F0C35D5D1A@KL1PR0601MB4697.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: gourav.singh.ext@siemens.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=0001db07-203a-4ae8-ba26-24b6838cdfd4;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-11-25T10:58:43Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|TYCPR01MB6756:EE_
x-ms-office365-filtering-correlation-id: 92549626-4896-4d29-74cd-08de2e61b974
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?eUkyRHdUYkg2c0ZLSU5BVDl1L2kvUGdMWmZUb0Y1dk82ZzFTeWxPTkty?=
 =?iso-2022-jp?B?SERLMCs2LzRWRGxUSDlDSHdtSGJMb1diTEFLMHFKQjhCRUQySHpGcnlY?=
 =?iso-2022-jp?B?OGlNMTRRUjRyWjI4SzFEeTBEWDRrN3RTbUxNUDV6NWFHRHpkK1dvcmxw?=
 =?iso-2022-jp?B?RkxPYXVhUUcyd3FzNVF4OE1YNHM2elRzZEFYOVRxbTVhTHphU1lGdmpm?=
 =?iso-2022-jp?B?NFdKWGM3ODlDTU5JZlBndCtwYkQwMmRoa2ZHUEtka2luZEc3Q0lWWjZY?=
 =?iso-2022-jp?B?UzBNMjNRTXJJYVZoay84bkFyU3lxWTlTci9IK1BWRG9JdXdUOGpMbXhh?=
 =?iso-2022-jp?B?aWplNm04YXVCL1grdnRtUGRCZmdBcFdOSDFlUkY0R0gzeFhTTXowSkxX?=
 =?iso-2022-jp?B?TUswMC9sb3o5enA3NVErTUhkVXEvNFFXZlZRV3pMVkdiR0JBRWNhSTJo?=
 =?iso-2022-jp?B?RmMrMXBCbStDYld6bjBPNTlXa0J2bUt0cjBJRHcxcWowdVZYejU0cUJO?=
 =?iso-2022-jp?B?MHVrMEhnZXFjQ3BtWjNKSHFUYmFtZG1lMXZYYTdXbHNFMDNsT2ppbmx6?=
 =?iso-2022-jp?B?OHNiQzNTQUsvMkMrdHZid21iNEtLQ2U4aEVOQmZ5UHBYUUM0bDJkYitI?=
 =?iso-2022-jp?B?b0JvUjRaN0ZKaTUrdy9ab205TnhYcGdoQUpENUhmUjl1SkJRajdkSTlM?=
 =?iso-2022-jp?B?OWplOUIzQ1pqekUzVFFJK2JtZzVGRUJCRlZ3MFJub2hXcTBla1RoRjdP?=
 =?iso-2022-jp?B?Zm9aWWVnMjY2V0NadHZPeTJRU1VRN1hqQnVxa2ZsY3orNFlpSjNFMzF0?=
 =?iso-2022-jp?B?MFFSb2h0VS9HZXZveHZETmhwRXgrVnJWczFOUlcrc0JEZ0Z0S0ZXWjlF?=
 =?iso-2022-jp?B?ZnRLbWxOaUNVaE5vNWhOQjgxMC81TE1MZUFBaEdWZlJSVWJFYzFKYWVh?=
 =?iso-2022-jp?B?V1AzYmprSUUrdk5FdEtURG9CYjVaVUhQeFJ6UlJ5SkJ4U1dLUEg4ckx0?=
 =?iso-2022-jp?B?RU9ORCtROWIzSklCMnN4eitnQzJINXhPTnlZZXdtbENtcDQ0c0srbnc5?=
 =?iso-2022-jp?B?R2lJbzEyeWwyVUQveDM5RUttNHd4ODF0R0pGOVA0S2djdDBwQ2N2cmdm?=
 =?iso-2022-jp?B?anllWlFSZWgwSk5nZzRwQUdyUUV4Qm5kTi9MVFh5dWxFNVY4Y05mRDJO?=
 =?iso-2022-jp?B?ZkM1ZFpSVjhPdFoyUjhuUEJZV2M5MjIwSFMvL3dFZ1VEdXRzME1QWTV2?=
 =?iso-2022-jp?B?S1dSOXdEWU1scDRXZkE5MDhMYlhuNC90NW9VR0dFRlZsR1loRkpURnZm?=
 =?iso-2022-jp?B?ZTQvV252TkN1YkFWL3BxZVlmdjc1NWd0ejlwYjhJZ2ZEM3BpOTBtMENH?=
 =?iso-2022-jp?B?T2lwMmF3QzBJMGd2QWx5WDB4NTMvaldjQUVmNHVZUHZsUUwvQ2dmaHlF?=
 =?iso-2022-jp?B?US9pZjhPZTZwb3doYVJvazhjSEh0ajIwZnJXWUhZQzZqM2t0Z1lmSjdC?=
 =?iso-2022-jp?B?UitHaS9qamREeDh2cEF3TTcwVVJFOTE0dEF6R00zcXZLWkZRUGk5Qnky?=
 =?iso-2022-jp?B?NlV1VTFDbnVtMmU0dmkybUVlSGtsV3ZJazZzV1VxNlIyUXN2VmVRMWZC?=
 =?iso-2022-jp?B?VFc4WVZTMVR6eDhkZVYzRzc3YXc4KytSQUdVMFQxT0kzOWozRENQU2Iw?=
 =?iso-2022-jp?B?bE1oZ0xPSXRDVnkwUUtsemNBRTU3R3dIYW44QWJwZDFlSERodlVLM3Fs?=
 =?iso-2022-jp?B?V3prNVVCblJrZXdnc2xlT1oxcWxOMWtYQllNd3N2ZEtldVhFYUhpNStl?=
 =?iso-2022-jp?B?WlVCRHFJaldSQWFJSVpURWRBMEtsS3hJVEFONG9aU25PMU5sZTFQS0tP?=
 =?iso-2022-jp?B?d0RQRzN4SkpMVjQxbFJKTlZXQU9KektuNytHU3BzZ0loa3ZRVys1VXN4?=
 =?iso-2022-jp?B?b1AzVktrNzZ3eEszeGJnRHBFTUM1S1p3azVtTCtnZFFiN00zK21OcExl?=
 =?iso-2022-jp?B?MzBRME9wdk13TDNBTnFTa2hKVGJXbTFnNW9DbGVUSVF6T2l0L0EwdXhk?=
 =?iso-2022-jp?B?aUxKNUZhTXdFWUVVZEYrNFJnenZxYkZhR1czdklGSEpvN0ppa1hYQTls?=
 =?iso-2022-jp?B?K0w3R3VSN1dnajFwUThEclV5K1dFK0hrL1g4ZXQrK2hCQnlidjlQS3dF?=
 =?iso-2022-jp?B?bit2ZzZOTzNxR1RRcnBPNlpDMzFweDZG?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?MklTWnZJM09jekZmZTROWDJBblVabngyZkh0UXExSlV4SXk2UlBicW1a?=
 =?iso-2022-jp?B?SDlXd1ZYbWw3QkRZZTlaM1R6bXV3Vnd5cVhMaU5nbDFnK2pJbU1iSFZM?=
 =?iso-2022-jp?B?NTlnL0N6ZytPT3pEaDFpSkl6NVQ0M0dCTFQ3T1pubkJsRmVkczJzRGRj?=
 =?iso-2022-jp?B?aURWWk1MeVR1YjlqRHM0WVFXRGRMQVYwWmVGdUdPMjkrckdoaGFOQnJ6?=
 =?iso-2022-jp?B?NjZEdGFrd1FSYXQ5ZU14TnhhOU51Rm42K0xxL05JcGE5QTNxOUk0dEVy?=
 =?iso-2022-jp?B?a25LcDhZUGFlaHlrUW5BZ2UxSUQzME40RWZYeE5WQzFOanlHQ3phY2JQ?=
 =?iso-2022-jp?B?RHltZXZ3SnVSWUthYzQvZ3FHOFhzamEzT3I2QitBU3Nzc0s0L3p4QVBo?=
 =?iso-2022-jp?B?Zlg4ZS9GUmh2Z3RQRWRCcEt1KzJWVVFhSDNDVVZ0eDVDWmpBNFpnNkQv?=
 =?iso-2022-jp?B?ME1WTHUyNG1Db3FMNmZ2RURSelBzUlpFaXhYZTl3UHVEOXlKWGJSU2p4?=
 =?iso-2022-jp?B?UlNZdnBBdERHQmJjblZtUEQ5UDJNVDZzV1dYK3lGVVpYOVZMQjBsYUx3?=
 =?iso-2022-jp?B?R1RoYS9pd0FsbUdQSi9nMTZiUWhneVU2RXd1dzRpY3gvQyswNnIrNWpN?=
 =?iso-2022-jp?B?ZEhrWWYxa1prb21tdDVMazA0ejQ3Wm5paUFjWEFGQVl2TnF2SDBpVFFw?=
 =?iso-2022-jp?B?THBQMzVnZVZMMElWZldBYlRvVGJuVy9NdGdXY1FVUlJVdk5BUW9kejJs?=
 =?iso-2022-jp?B?Qk8vbktwNFRDODdTVHVnd2d0NmhLbVRmdmtsckpSSTJGanppQTJIdkF6?=
 =?iso-2022-jp?B?OUJScEZOKzN5dTZjYlErVDAyNXI5b241RzFqd0lNQnM1K0VBdW1MWTBE?=
 =?iso-2022-jp?B?dHppSzVjajczVDN3V09xdUhKWU82Mzl6WUlMd2taUGtPRHVEZDlESEl5?=
 =?iso-2022-jp?B?NTNvUTFxakF4ZFJscUo2T1hqUkJRUWVDVnNuUVk4YzFDYTRLOTBjd2NC?=
 =?iso-2022-jp?B?Z3RybTY4RTlxWUo5N0pKTzUyUVVNMDhyRFJUWXVMT0gvdjhOMW9kM0Fh?=
 =?iso-2022-jp?B?cW9wZzFWbTJwYWtiQW00U3VZdXpkV0FvUEFCTXZsaXJ2N0gzL290bjlI?=
 =?iso-2022-jp?B?OEVFWUcrSXkwZVN2TFVvdTVwcnhQd3ZuS0I2N3ZzaXFveHhSaHd2VFp4?=
 =?iso-2022-jp?B?dStqRU1mWnhwYTVOaC9EeEZZZGFmd092VWFxekY0elFqb0hmZVIvZHpi?=
 =?iso-2022-jp?B?YjNxUTJJRjAxM1RtSzRvV1JnRkkyZHlBQWg3NUo2cEZremVreDZKYWtX?=
 =?iso-2022-jp?B?UUsvT1NYRkVIQjgwWXY2c0hKN213ZEc1T2lvZUhpT3hsbmtpY1psbVZ3?=
 =?iso-2022-jp?B?eFlZNEtlUFJuWjFGNm0wdG5QR2I1UnBpREUwWnc5MWlYNFR6bkdFY3BB?=
 =?iso-2022-jp?B?Q1d2M1MwVFU2alBwMHM4ZC85eHBKSFdTcVJ4WlZrYnZCb0lDNWp2QlVa?=
 =?iso-2022-jp?B?dWJubkpRbVRYWHYyWS9ua01YQUpHaG44SFl3UHB6S3R5Q1I3UVMwK2xn?=
 =?iso-2022-jp?B?NnBJKzErZ01WZFFtTFliRzhvTVFYaGltTmVrc2FYV1RlbysyMklEbFRP?=
 =?iso-2022-jp?B?VTJCcUM2bnhGV0dqc0FUUFVVdjJ4TU1MMDI5QjVVZWp0cXZldnhkcnI5?=
 =?iso-2022-jp?B?TlV4YlhJZVR0YldYakVVT3ZvK1RLQ21jQk1sVWpHY2JtazNSL0l5dFor?=
 =?iso-2022-jp?B?QWV5NTRTd0tDbU1kZ1NBZk5LK3pnazFlQXZhUVpqZSthR3ZEVmZxaHVB?=
 =?iso-2022-jp?B?SnJZbldxU0s4bDBSVkF3R3pLc3R0R2lGRXZFSnFnMkdDNUFnbTNSK0Mx?=
 =?iso-2022-jp?B?VUx3UGlTcDJrZzVHVmg3SjM4ZTBMcDBNdzdMZDNwT1ZHcW50RUdoMy8y?=
 =?iso-2022-jp?B?VzlCREhSZUd0UnpIS0trcjhJRUlCVWdmdldYejNTNGVPZ0VRSHQzZDFr?=
 =?iso-2022-jp?B?THVRUkZteGRaK2U5YjYzdU5qZWZ3eXM1ZGFNVGtRTE9HWVJURDFTL1BM?=
 =?iso-2022-jp?B?Y0V4ZnVRckxXQ0MxTjRPaXhhNStDYUZ1L09KaktHYmJGbC9ER3J0OFQx?=
 =?iso-2022-jp?B?Umd6KzBGdkhBNGMxVmRGdzcvT2k2Y28xMlZEVEg5czlUTkUvbkYrSzZi?=
 =?iso-2022-jp?B?U3NLU0dabnpla0lzT2h1cFFKY3pyWkZiYmdtRW04STBTeUcrdjN3QzhE?=
 =?iso-2022-jp?B?N2xSNHJzTUxGNWFCazgwbm5JOThMeGVERW1aZ2JPdDhYb3FRK1oxemRK?=
 =?iso-2022-jp?B?TFJRRVVjWnF1Y3p0Mi8zUysxeWJsTmdjcHRJMCthVWJZUFkxOFREeGQz?=
 =?iso-2022-jp?B?V3dlQk09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92549626-4896-4d29-74cd-08de2e61b974
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2025 09:37:19.0686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jjk1lG8+10voDHH/jXs7MFkEewIsNYD+Ewf1sd6Y9R+Oyo53Y0PDTdi7qBr6crPGQ5KNAUIglZPZLWZk4c8TMgrIS0H8Wu4EqyTE5IZSjFLhwCDa269QP4P3vs50R7vX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6756
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Nov 2025 09:37:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20760

Hi Jan,=20

Just an update for IEC layer tests on trixie image.=20

I've created trixie based security image for QEMU by applying this patch an=
d executed IEC layer test cases.=20
qemu-arm64 and qemu-arm --> No issues, all tests are pass.=20
qemu-amd64 --> One fail test out of 44. It is passing if I execute it alone=
, the reason is not know yet.=20

@Singh, Gourav Thanks for testing.=20
Let me confirm, did you execute IEC layer tests on qemu-amd64 and shared th=
e log file?
=20
Thanks & Regards
Shivanand K=20

-----Original Message-----
From: Singh, Gourav <gourav.singh.ext@siemens.com>=20
Sent: 25 November 2025 16:39
To: Kiszka, Jan <jan.kiszka@siemens.com>; cip-dev@lists.cip-project.org
Cc: kunijadar shivanand(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <Shivanand.Kunijad=
ar@toshiba-tsip.com>; dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <dinesh=
.kumar@toshiba-tsip.com>; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$=
B""#D#I#T#C!{#C#P#T=1B(B) <kazuhiro.hayashi.f74@mail.toshiba>
Subject: RE: [isar-cip-core][PATCH] fix(security): add libpam-systemd in De=
bian trixie

Hi Jan,

After applying these changes, the IEC test suite now passes all test cases =
on the Trixie image. I've verified this on my end, and I'm attaching the re=
sults log file for the test suite run on the cip-core-image-security Trixie=
 image.

Thanks,
Gourav

-----Original Message-----
From: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>
Sent: 24 November 2025 22:07
To: Singh, Gourav (ext) (FT FDS CES LX PBU 2) <gourav.singh.ext@siemens.com=
>; cip-dev@lists.cip-project.org
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>; dinesh.kuma=
r@toshiba-tsip.com; Kazuhiro Hayashi <kazuhiro.hayashi.f74@mail.toshiba>
Subject: Re: [isar-cip-core][PATCH] fix(security): add libpam-systemd in De=
bian trixie

On 24.11.25 17:30, Singh, Gourav (ext) (FT FDS CES LX PBU 2) wrote:
> Hi Jan,
>=20
> Regarding customizations or configurations for the `libpam-systemd` packa=
ge, which provides `pam_systemd.so` - a new systemd mechanism that replaces=
 the traditional `/run/utmp` for tracking active user sessions in Debian Tr=
ixie - it is necessary to ensure that `pam_systemd.so` is included in `/etc=
/pam.d/common-session`. This replaces the traditional role of `/run/utmp` i=
n session management.
> Ref:=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist
> s.debian.org%2Fdebian-release%2F2024%2F05%2Fmsg00150.html&data=3D05%7C02
> %7Cgourav.singh.ext%40siemens.com%7C69f7415c2bc3402b8cde08de2b77b21d%7
> C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C638995990271096290%7CUnkno
> wn%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXa
> W4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DzbwdGBW1zzz
> p3xN5q0UW3qN5o1MXmzbBmJv3uQdILhY%3D&reserved=3D0,
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fddp-
> team.pages.debian.net%2Frelease-notes%2Fen%2Fhtml%2Fissues.html%23the-
> last-lastb-and-lastlog-commands-have-been-replaced&data=3D05%7C02%7Cgour
> av.singh.ext%40siemens.com%7C69f7415c2bc3402b8cde08de2b77b21d%7C38ae3b
> cd95794fd4addab42e1495d55a%7C1%7C0%7C638995990271126607%7CUnknown%7CTW
> FpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIs
> IkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D5ry3XapBLPScmMpiz5
> bdwF%2F9MVx0%2FG6reUH%2Ba5pYxXA%3D&reserved=3D0
>=20

This all makes sense so far, and if no one complains, I will merge it soon.

I furthermore assume that our IEC testsuite will "just work" (again) with t=
his applied, right? Switch-day for the CI to trixiw is now Wednesday, or mo=
re likely Thursday.

Jan

> Thanks,
> Gourav
>=20
> -----Original Message-----
> From: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>
> Sent: 24 November 2025 12:21
> To: Singh, Gourav (ext) (FT FDS CES LX PBU 2)=20
> <gourav.singh.ext@siemens.com>; cip-dev@lists.cip-project.org
> Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>;
> dinesh.kumar@toshiba-tsip.com; Kazuhiro Hayashi=20
> <kazuhiro.hayashi.f74@mail.toshiba>
> Subject: Re: [isar-cip-core][PATCH] fix(security): add libpam-systemd=20
> in Debian trixie
>=20
> On 24.11.25 06:06, Gourav Singh wrote:
>> In Debian Trixie, /run/utmp has been removed, so traditional=20
>> session-tracking mechanisms (used by w/who) no longer work.
>> To restore secure and correct session accounting (needed for=20
>> enforcing limits like maxlogins to comply with IEC 62443 CR2.7_1), we=20
>> can add libpam-systemd.
>>
>> This ensures that PAM can register user sessions with systemd-logind,=20
>> aligning with Debian's design for Trixie.
>> See Debian-devel discussion: "/run/utmp is no longer provided in=20
>> trixie ... replacement mechanism provided by systemd."
>>
>> Ref:=20
>> https://list
>> s.debian.org%2Fdebian-devel%2F2025%2F04%2Fmsg00011.html&data=3D05%7C02%
>> 7
>> Cgourav.singh.ext%40siemens.com%7C13545a99022f43a55dce08de2b25d0fb%7C
>> 3
>> 8ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C638995638612273708%7CUnknow
>> n
>> %7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW
>> 4
>> zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DtNzGl6b239zR
>> 7
>> GFA5WPQwQwSi0fRIhXp5hQchE7pxKw%3D&reserved=3D0
>>
>> Signed-off-by: Gourav Singh <gourav.singh.ext@siemens.com>
>> ---
>>  .../security-customizations/security-customizations.bb         | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git
>> a/recipes-core/security-customizations/security-customizations.bb
>> b/recipes-core/security-customizations/security-customizations.bb
>> index 717e2d3..d8fa22b 100644
>> --- a/recipes-core/security-customizations/security-customizations.bb
>> +++ b/recipes-core/security-customizations/security-customizations.bb
>> @@ -25,6 +25,9 @@ DEBIAN_DEPENDS =3D "customizations, sshd-regen-keys,=20
>> libpam-google-authenticator,  # - libpam-passwdqc: Preferred for newer D=
ebian releases (post-Bullseye).
>>  DEBIAN_DEPENDS:append =3D ", libpam-passwdqc | libpam-cracklib"
>> =20
>> +# Append systemd PAM package to limit concurrent sessions in Debian=20
>> +trixie DEBIAN_DEPENDS:append:trixie =3D ", libpam-systemd"
>> +
>=20
> So, no configuration needed? And does this obsolete any other dependency =
in trixie?
>=20
>>  do_install[cleandirs] +=3D "${D}/etc/ssh/sshd_config.d/"
>>  do_install () {
>>      install -m 600 ${WORKDIR}/ssh-remote-session-term.conf
>> ${D}/etc/ssh/sshd_config.d/
>=20
> Thanks for tracking this down. I suspect that our certification efforts a=
re still focused on bookworm as baseline, but this is an important step ahe=
ad already. I also hope we can soon switch CI to trixie, currently waiting =
on lava-docker updates on the workers.
>=20
> Jan
>=20
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center


--
Siemens AG, Foundational Technologies
Linux Expert Center


