Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D53C369AB
	for <webhook@archiver.kernel.org>; Fri, 18 Apr 2025 05:01:34 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.6026.1744952486133853908
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Apr 2025 22:01:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=RKZX2Y1D;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=1744952458;x=1746162058;bh=Va
	unt4ADKuKcRprMj/DboMYLBMLI9HhPWqlJgg4Wjs8=;b=RKZX2Y1DJYX2rtNpLItEzsxj9mnJ0k2D
	tofwPZcZvFVv2H31RM0s0LUPxRcWFnzbtxx5PFQmAUQGnZl6cLPHuAWkYSnCbWnD5yuMWL7KXN7Y6
	Krs/uI6yLGlFtqYXoVVEooxVEMXn1MugGUA6zfmQThYJEP+XfklIg4iwJ2nmbqPrx3U5iyox4QvIL
	2pNS9q7VxUuV8/QHZz0oou2vYcO0+uGfMua7Ae9ldplUq7EQOGE/1pq1jGRqkaDo2bhcjwmCCtmCD
	VLLIP4VqMUiiXNxFimIU/d5Qv0wvLaA2iWdZOWufFFuwdJZDeo/8FLImrS4QJbGPradK9zeOtmdna
	fQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 53I50v9X1950156; Fri, 18 Apr 2025 14:00:57 +0900
X-Iguazu-Qid: 2yAbaKzOhfZaLmkH5Q
X-Iguazu-QSIG: v=2; s=0; t=1744952456; q=2yAbaKzOhfZaLmkH5Q; m=ZxapMD8++BO0SVPNqMQYHE3Sbpx7YDGcyF4NsM5+srg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 53I50sOT755480
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 14:00:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OuBgSU7B1G7ImW7ZPLQeoJKeuQsmiQ7qCaZwTORx0BGLVvZ42dl36oxHTNHeJtvEc3jh+YfdFw0Z2n6QtgREE2l4FmoCg2RzYidzAulh82b8Ab9D9VSPjBpWc9mfrjWdRGmbrq4n8mt5CbDVhssx8eLhw7JjwBLQm35VN+MUeEzDT0Iiz2EcqkwjZB9NH6YFHbf/S4F5+AWyMuq8zufbU1iq3ZBsr261iYCarx5ZJpy2hkmldL+OJ6W9G3fkPe6aHu0FK9hN1g0ir5TdTi0K7bhHFa6/vymUfupnGkTuqRtKdawNqOdR2UOMl/jeshwybOgr8/q/TGoEiwq/gXoDIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lqif/SGJm5zMcKs4k9EdgxnDRCl8SW8Xl9K4csI0OUw=;
 b=TKzMUJOAbtVUVlUNwQ6c9KZPQa3I3jNzZ/cOQga/Pn3q4Bn4Nyb1E05Rw7xYWR+rZJ9fiVN44F8UKl4sgSbpwSGxOaxDsEhbV+bgbJ/wX6rvjtN86+oizHJtuS9TI6RKB1Qt5h4kjgj8VqVtojIQvq1MlWqGDQKK/seZs8k3R/8MHYwSRE9kArNPHdq/kHpb6chYNEDyiDC+YL1xf1iMXTlpfD7GOssBQR8ADju9SOndIHoHxutSL9i1RW7GePI0358FenEbi9aDNWM957sDnMG0uUzH39o6cGPTcAP6o6lXWJYLMuijE8z4VLeKACZWwVRQtnMlQV/gzIYgZ6i3og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>, <uli@fpond.eu>,
        <Chris.Paterson2@renesas.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v6.1.134-cip41
Thread-Topic: [ANNOUNCE] Release v6.1.134-cip41
Thread-Index: AduwHsNNi6dKNp0UTj6NhtXQXUgI4g==
Date: Fri, 18 Apr 2025 05:00:49 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818EFEF72E4168C4F17A77992BF2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYRPR01MB15565:EE_
x-ms-office365-filtering-correlation-id: da32aee0-18ea-48c6-9141-08dd7e35fc85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?WC9jU0t1STNTRXBWMEg0K0xVVEVuZVJNTnVIRVJGMm5lQml0WEE2NEVr?=
 =?iso-2022-jp?B?akNiOU5TdkdVclc0TTdYOHpPRE4vdUJPaDNtTThPWGk0VjZseFBvdktY?=
 =?iso-2022-jp?B?N3NMRjN1dHEveXA1dkJDMTJvSytNek5GZjI5elROYkhIemJESDRicXp3?=
 =?iso-2022-jp?B?ZVp2WVBMeHBVY2wxTWwvYVpRK1RzMnl3eDl5UG5ndk5ycVpIWjRxTFhs?=
 =?iso-2022-jp?B?aDNIZ1FnV2lhOUtnMGo2b3VGQjVGbWluanlqMU8zdmNta1VkSUFEMmsv?=
 =?iso-2022-jp?B?NzdqbGUyeXJwQ1d2d2xWeFZmVEdLaWpvSzI3YUdPcW5vcGVUNHRmS1lG?=
 =?iso-2022-jp?B?VGFvdFNqTlNVQXB5Rm1qWTZoemcvU2xZWk8ydU9TVktMR29MbER0TmYx?=
 =?iso-2022-jp?B?MzJpR0ZjOEtGOVJNV1RkOHF1REVFNi94Rkord1c0ODJmWWVWakRqNFNo?=
 =?iso-2022-jp?B?UjZIZzliaGk5a1grakJROS82S2FKY0swdDllUnpEc0pVeUlQM0xyZHJG?=
 =?iso-2022-jp?B?YjlSdEgvWjhCQnJ3TGlZaytXTEs3NGZPRGpxRUVJZzhKZVFEdVBFcGpv?=
 =?iso-2022-jp?B?NnMxM0lCVGhhMlZIRlhjaXZwL3pkMm1YNVRWK2dxUnpWZTF6c3dyT1J2?=
 =?iso-2022-jp?B?eThlL1dNZEsyZVBtaW5Sbkt0bHdHWWhRMlZLZVNPWDl2SUw1L0M1djJz?=
 =?iso-2022-jp?B?Mm9GSGRZbzJmL0Z6R0k3alVJMnhYWk93ZVBVNXo2SXA5cU9WaVBVM0w4?=
 =?iso-2022-jp?B?NkxwNkRkWXFBbTRPVHZPcWl4L3czUjRleXc5Y1hUUzdlV25LNFJuRkdX?=
 =?iso-2022-jp?B?RTcxbytaejVsZGltbG45b3ZkUUJVSjZEOENqZHRWUkZ5dkxGa0NBTkRP?=
 =?iso-2022-jp?B?Tjd2NTdScllJR3NscWpJV2QyRjhqazlKK2d1dkZhZUszQjZzK3pLMkth?=
 =?iso-2022-jp?B?KzFOSVBORTgrMlEvOW85bGRrUWQrdHJPZkQxSU13RHo3VVh1dHMvdzJF?=
 =?iso-2022-jp?B?MURjZ1pkazBYRDRPVVFPWVg3TTdtR2JBQTRlYzZ0UFdBcHN2aHpzR0cz?=
 =?iso-2022-jp?B?dGFZM2xUbk9kSlk0TGkvOGlSbzR2YUd3bk9oOVprYjdBMjlJZEpkM1FO?=
 =?iso-2022-jp?B?ZmdPbmpNTmgrOFpmb1RNUWlncWVIWUJ1SEJLUG5qUWlkU0lhdkJ2ellV?=
 =?iso-2022-jp?B?aG9vRlpvVjNWdHUySk1wOUhmRHRaUGJ1ZzYyZ2NoVEEwSWwrUnRxemlw?=
 =?iso-2022-jp?B?d21tMkN5QnBIQjVNVzBWTXFoemM5bVVnREMwMWNKaU9HSmtjMEh4bkgv?=
 =?iso-2022-jp?B?ckxaMFh3RStJVVBpTFhvTEc3WkJQWEZWeU1UZ25naUxsL3lsTGs0ZTJk?=
 =?iso-2022-jp?B?S2lkU2ZzWUsvWjAzSWVPeDdlVEh1K09RUkpMRXpZaFhsU0VJYjc3RzEw?=
 =?iso-2022-jp?B?WGxSMzFIYUwyc216cW41elhYWDduQ3NsYlRSZ2V6WUJJMFc3Qk9sMytM?=
 =?iso-2022-jp?B?Vi92N0VUQmRjcVNsZ2dWbEc2SlI4T3VGZjllV2xUWHpJMlRSdmx4YnUy?=
 =?iso-2022-jp?B?d3BtaDJZZHhnSlRHZDBpOHd6QTBqdmFrdEhhVFd0NDgySHhPOHE2MjA0?=
 =?iso-2022-jp?B?RHIzaXYwVmNQUHJybzgxejNuSHBIZXE3S09XV3Z0SmQ2S0UwajducTRZ?=
 =?iso-2022-jp?B?eTNOMTJ1bU53djhmRU9EemJoYVlJUzU2RlRoZk4rQWxLS1V5VFBIYlNW?=
 =?iso-2022-jp?B?T21uQkIxZDVzeVFtR2h6ZmJ0eVVTK2tYcHhlSDVTaVNyZkF0bkErWnlQ?=
 =?iso-2022-jp?B?ZUdtZTQwdytVNDRGK016OTFpeUl5NFJDdXpvTkxWWEVoWXp5bUxkTGta?=
 =?iso-2022-jp?B?UkZOWTdlbW4wUEZ1aFBaNHFrWlBqWUJVTHA2UFNWRzc5TkNST1RxN083?=
 =?iso-2022-jp?B?LzB3TzFmd09Ld09nWlcxS01DQ1VOTHgrQUVRMXpoaVRCcE9DZlQya0Rl?=
 =?iso-2022-jp?B?Yk96M2pJUFZId1VuelQ1eGZ2YlZNQlFaWW0yL1poQkV2WGhQeFdUTE5E?=
 =?iso-2022-jp?B?bE1Qc09MM3p3Q2JtMjd1MHhvdlZNR2NMUGZEQlFrVjdydW8xSGNYd09P?=
 =?iso-2022-jp?B?cWhDNVFxNDVVek8xSEFXeWJSSm5adDIxM0tzbzFCYjlTSUVWSGViQ2V5?=
 =?iso-2022-jp?B?MEtjPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ck1zNzlibmI0amdicG0wK0RRSEdHQlhTdjB2NGo3SmdBTEh6UWZKVmRx?=
 =?iso-2022-jp?B?b2hNUW5JT0JZNFdIZS9QL0NqKzJSRW8xcVpUby9nQ3ZkVUN0dnR2SGxl?=
 =?iso-2022-jp?B?WGFZVDI4QWJ2TnVJb1AwaXI0WEw4bGdqYVkvb2VjNXdqdFQ0SVo2ejBh?=
 =?iso-2022-jp?B?NHBaSElXVW1HM1Q5K09XVE9NRUNFQnFnOEMzTFlUanNudDZLZ1d6YldR?=
 =?iso-2022-jp?B?b3BoSGlEZUJabllNd3NlVDI3MU5VMkloQTI0R2o1dTQweVlZZnE1eGVI?=
 =?iso-2022-jp?B?UzNTRjhsK3J5TmQ3ZnBXaGJlQXdWRXBGSDk4SWo1SjJBbytIS1JDcjlG?=
 =?iso-2022-jp?B?Qk9Mb2tJS3Roa3BkMmtqQVNyOEFPMVhYK0FZNnRoSGJGYmFOenJQaHVy?=
 =?iso-2022-jp?B?aG0vRHRNZnBNMHdEaERhWG1XWUxsdExWTzBwaVp1cGJ5SlpmK0YwUGZH?=
 =?iso-2022-jp?B?cTRxcUkzbXVEMmVTaFo2bE9tTzBaVUhHUkt6NE53a3NZWVMwY3FoRDRw?=
 =?iso-2022-jp?B?M1diYkkwa0JMVDI1d0VqL1VvS21zMG5EUmJ2RlYxdVU5bFpJYWZaMXVm?=
 =?iso-2022-jp?B?RXh3VTNoaENXNDFpSVhKVTRBMjZyc1Q5ajg1Smlqc21YeVAzMkR3MDhs?=
 =?iso-2022-jp?B?ck16S0J6NU5xR1ljbFVJdHN3V1hNRjFFQ0JRWnp0Nng5L05DZWMxSXBC?=
 =?iso-2022-jp?B?NE1rbGdmSzJvemlaRVJQeTV3TUZzTDM3a2NNU3AxQ0JySHR5Z0JBMjNh?=
 =?iso-2022-jp?B?eXdoM1orOEhRWWlVU0pneExTanNWdEZHbk8xZ1pHMVpyQXhJYUVaWDMz?=
 =?iso-2022-jp?B?VjZoUDFuYlZYRjdpV2cvcTdwaDY0T2JjTm43akxNU2FLYlRaUHlaeG5u?=
 =?iso-2022-jp?B?cHJpRGxkVTAzZnhrMGdVLzNWTDRWN1laNWVNQjdLQVNqVHVXSm14dVo1?=
 =?iso-2022-jp?B?Sk9rQm52UTZzSlFLSzN5am1nV2VQMlNvSzdGZXV6bStRVC9ya2FWRjlz?=
 =?iso-2022-jp?B?SEYyMmR2Zjk3ODNKZmdPendPL0RkbnJwS0o0ZkluQm1Xd3FOeWRzOWQx?=
 =?iso-2022-jp?B?VFErS3BBcmtXQnRkZ0t5bkJXTmR5cWNaaDJ3S001U0VxQytYdnRuVVVY?=
 =?iso-2022-jp?B?ZjAxWCs2SWs2SnFCZkZ0OC8rRUJ6NUFPRWFDRTNXSk9zQWFxTzQ3Y3ZI?=
 =?iso-2022-jp?B?MkFaWnV5YnhqU3cvZ3hJMUt4KzlkV29jNlZySWRRclJsblM1YlJmTEEw?=
 =?iso-2022-jp?B?Z0NBS0w5dVNnTlQ3V0ZlUStXZ1JIWUZtSG5NOVNOV3dma25WdDdNanFD?=
 =?iso-2022-jp?B?dDNEbU1ORldQNnJ4MkhXdjZSbnlBeUV0c2hRZ0h4cDhRRUwrMnp5UFRm?=
 =?iso-2022-jp?B?ZUdaNk0wQncyVWRoTjc1cURRNFRCNE9adWVWaHRhNEpnNWt6dlk1VU1x?=
 =?iso-2022-jp?B?alljWDhBeGkwYmVVNWJrbWEySnR4dVVZaDJGendRY3JFVnJQV0g0Unk0?=
 =?iso-2022-jp?B?T3lEL0pIKzM1YjNySHhjZElFK0RjYnNPcWhtYm5wc2NqZnJxQkdXZmxy?=
 =?iso-2022-jp?B?WUFRTDlHeGxCSE1KemF3SUd6Q0hLNVQ5TkF5eUNLK3RzMUpLYjl5ZXg1?=
 =?iso-2022-jp?B?d3dqdmhZVHJNajlzZzVzcHNlcStkUGlOWStJNk9SVEtFektpRTZWbzYr?=
 =?iso-2022-jp?B?NXUzZ3BYRUt5MTNUNHlpUC9pdC9ORUt5TEJNWTFGa0JhQndFaVYwWDRm?=
 =?iso-2022-jp?B?Vmw1bG1HRm1iaFY5Z3JnQVFYTE1lZm5McXhXNmNoUUlXbUd6a25WU3JS?=
 =?iso-2022-jp?B?enR6YThuR1Y2S05jeHZSVnBObVlXekQva01RSWU1WEd2eHUwY2NNVkpi?=
 =?iso-2022-jp?B?am51eGZYblpyVmxpZlZmWnJLeTdSbEZzNGI2VVA2UnIrbWNXTWVLZHNO?=
 =?iso-2022-jp?B?T0I4dmczcDJmZ0ZJQTFSZXNXNkE1ektYVWZFZWN6dWM0YUtEeHMwN2VG?=
 =?iso-2022-jp?B?R282amREL29zNGozbm5pd3M3VEwyRTFSb2luT1pDaWtvb3U0VmZBTnN1?=
 =?iso-2022-jp?B?eFVKLzZDalRDempBajQ1eTJjK1RxUFVKdXZKSUJCejBFV2NVdDFOVlY1?=
 =?iso-2022-jp?B?VW5URU85bTluYUhkVXNZMm9adWhydXgyOTdraUlzQ0ZHei9rNUhvWUVk?=
 =?iso-2022-jp?B?L1hmRzQxL3BEMVlCb3Qwb0ZMbjJVNzVITUlmT296VFl0SVFHN0tsUW5j?=
 =?iso-2022-jp?B?bm9CWUNpMnJKZFIrUzQ0c3p1MlkwcjdtMHJsZFVSMGlFdVY1QTR3dDBS?=
 =?iso-2022-jp?B?M0hJaGVVTTlOZ2tHeFNQSjNKdkdBTHhsZXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da32aee0-18ea-48c6-9141-08dd7e35fc85
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 05:00:49.1372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fHf8ayPeyN8eRXz4NCAv/MNudx8snl5cOvv32ONRgAibyZR2aBC8xGw4lYb6MGlHCPAvTQ6zxEkeYeeU3rPDdUlw4+WM6jG6MBVTyz64lFD8T9/EUQGss+6lqjHmr6aI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15565
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Apr 2025 05:01:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18525

Hi all,

CIP kernel team has released Linux kernel v6.1.134-cip41.
The linux-6.1.y-cip tree has been updated base version from v6.1.132 to v6.=
1.134.
And this version included updates for the Renesas ARM64 SoC iic (i2c).

You can get this release via the git tree at:

  v6.1.134-cip41:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      38336ea2d1beb9af557adcc91b04e82478f539bc
    fixed CVEs:
      CVE-2024-46772: drm/amd/display: Check denominator crb_pipes before u=
sed
      CVE-2025-22018: atm: Fix NULL pointer dereference
      CVE-2025-22020: memstick: rtsx_usb_ms: Fix slab-use-after-free in rts=
x_usb_ms_drv_remove
      CVE-2025-21918: usb: typec: ucsi: Fix NULL pointer access
      CVE-2025-22021: netfilter: socket: Lookup orig tuple for IPv6 SNAT
      CVE-2024-38611: media: i2c: et8ek8: Don't strip remove function when =
driver is builtin
      CVE-2024-50056: usb: gadget: uvc: Fix ERR_PTR dereference in uvc_v4l2=
.c
      CVE-2025-22079: ocfs2: validate l_tree_depth to avoid out-of-bounds a=
ccess
      CVE-2024-58093: PCI/ASPM: Fix link state exit during switch upstream =
function removal
      CVE-2025-22055: net: fix geneve_opt length integer overflow
      CVE-2025-22038: ksmbd: validate zero num_subauth before sub_auth is a=
ccessed
      CVE-2025-22033: arm64: Don't call NULL in do_compat_alignment_fixup()
      CVE-2025-22097: drm/vkms: Fix use after free and double free on init =
error
      CVE-2025-22071: spufs: fix a leak in spufs_create_context()
      CVE-2025-22050: usbnet:fix NPE during rx_complete
      CVE-2025-22060: net: mvpp2: Prevent parser TCAM memory corruption
      CVE-2025-22081: fs/ntfs3: Fix a couple integer overflows on 32bit sys=
tems
      CVE-2025-22072: spufs: fix gang directory lifetimes
      CVE-2025-23136: thermal: int340x: Add NULL check for adev
      CVE-2025-22041: ksmbd: fix use-after-free in ksmbd_sessions_deregiste=
r()
      CVE-2025-22035: tracing: Fix use-after-free in print_graph_function_f=
lags during tracer switching
      CVE-2025-22040: ksmbd: fix session use-after-free in multichannel con=
nection
      CVE-2023-53034: ntb_hw_switchtec: Fix shift-out-of-bounds in switchte=
c_ntb_mw_set_trans
      CVE-2025-22045: x86/mm: Fix flush_tlb_range() when used for zapping n=
ormal PMDs
      CVE-2025-22086: RDMA/mlx5: Fix mlx5_poll_one() cur_qp update flow
      CVE-2025-22066: ASoC: imx-card: Add NULL check in imx_card_probe()
      CVE-2025-23138: watch_queue: fix pipe accounting mismatch
      CVE-2025-22044: acpi: nfit: fix narrowing conversion in acpi_nfit_ctl
      CVE-2025-22063: netlabel: Fix NULL pointer exception caused by CALIPS=
O on IPv4 sockets
      CVE-2024-46823: kunit/overflow: Fix UB in overflow_allocation_test
      CVE-2025-22095: PCI: brcmstb: Fix error path after a call to regulato=
r_bulk_get()
      CVE-2025-22025: nfsd: put dl_stid if fail to queue dl_recall
      CVE-2025-22075: rtnetlink: Allocate vfinfo size for VF GUIDs when sup=
ported
      CVE-2025-22027: media: streamzap: fix race between device disconnecti=
on and urb callback
      CVE-2025-22089: RDMA/core: Don't expose hw_counters outside of init n=
et namespace
      CVE-2025-22049: LoongArch: Increase ARCH_DMA_MINALIGN up to 16
      CVE-2025-22042: ksmbd: add bounds check for create lease context
      CVE-2025-22093: drm/amd/display: avoid NPD when ASIC does not support=
 DMUB
      CVE-2025-22056: netfilter: nft_tunnel: fix geneve_opt type confusion =
addition
      CVE-2025-22054: arcnet: Add NULL check in com20020pci_probe()
      CVE-2025-22073: spufs: fix a leak on spufs_new_file() failure
      CVE-2025-22088: RDMA/erdma: Prevent use-after-free in erdma_accept_ne=
wconn()
      CVE-2025-22058: udp: Fix memory accounting leak.
      CVE-2024-46753: btrfs: handle errors from btrfs_dec_ref() properly
    added commits:
      CIP: Bump version suffix to -cip41 after merge from stable
      arm64: dts: renesas: r9a09g047: Add I2C nodes
      i2c: riic: Add support for R9A09G057 SoC
      i2c: riic: Pass register offsets and chip details as OF data
      i2c: riic: Introduce helper functions for I2C read/write operations
      dt-bindings: i2c: renesas,riic: Document the R9A09G047 support
      dt-bindings: i2c: renesas,riic: Document the R9A08G045 support
      dt-bindings: i2c: renesas,riic: Document R9A09G057 support
      dt-bindings: i2c: renesas,riic: Document RZ/Five SoC
      clk: renesas: r9a09g047: Add I2C clocks/resets

Best regards,
   Nobuhiro


