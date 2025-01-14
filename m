Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B42C02183
	for <webhook@archiver.kernel.org>; Tue, 14 Jan 2025 05:45:41 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.38863.1736833537570105784
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Jan 2025 21:45:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=T4GBqVfq;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=1736833513;x=1738043113;bh=7D
	zeGki2032vT1Eplyy+ZnrWnrpX13P9FmRwCgKaYRc=;b=T4GBqVfqAkfZOBzbcBeCRqGQwEyNri1v
	NommEXsX7m6LHoDMvPJmkzr0mmKqk/k5jziRpw6heHmJ0x2T19Jk5S9Nt/4ggjNa0xN8oIpwjVSEe
	H5mBGiEB1rHDlvkJlCgHJRVyZPSHYLZ45KfT7iiByzcnV9eEvf03Wwc/MKerIXQ4JIlR1gI6wKrc7
	UfrCiZsMgcRkKYugM7RnoknMGX7dBBrjSuf6V9DlnVdgD/kTIqwOFimzFfUsloa1ZN1cGINFl8fvP
	kLQMcr6o3tVDmWl1viq+jb3AH+oZuDy38oRnlQloWGDtlKyozcgycaVnRo49w0wPFAx3w/Y4REYWZ
	NA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 50E5jCa64048205; Tue, 14 Jan 2025 14:45:12 +0900
X-Iguazu-Qid: 2yAbJ3LJ1CQWFR2QSM
X-Iguazu-QSIG: v=2; s=0; t=1736833512; q=2yAbJ3LJ1CQWFR2QSM; m=j/ZOOTp/rQiZmxRMCVOqLIbN4CgIWxmjRDH9SEzNQz4=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 50E5jACs1242236
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 14:45:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZWtWg2n4T20c8Lep5QTQ4j6HrkTzRLXR0lBIcTHbhCWg1BRL9Bu7bdFCZrVeRbXu5OdxcIk3XuAW5NOxXQ3sxC2hZQck5CQ2eO66fGW8SEH7EB1nkARe55dNgcYK7LKoy9d3encs/W4zvtcdJnryNRS6gDnQ9WzlRINHFHz5E2B04Ojnx86qI+qC41S6Vt8C6nZHgZ2WaikvWQEX1EpBQ+sFL/RH6dZUdYs8NQJYvgbX/lMI9PJ0P8v2TXEvJepNNCc3piQIPSCy6gRoJgxS5yg9lxZdNSfyYylT54Qo5FTZ1DQnm228SNmYtRrT4Oa4w8hpksTLbygN4QC1ezFqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8mKlewZqyv7waQqlAfvE5j31QmySPGVPtBVd+x+Ab8=;
 b=uuyrKBAF5oxGRv50wE8QcDPB+JWK9FxiH1+OQYKVV86LuXNk4r/JhiVMaSmWoNrzl3kYt6KSPyxPKOa61eO7dOGa6e1AdEElginsMiav0vdaPuJjSYfNwUg+MzbEC8cMHdWT2HutFoDqYCqxGEk00vIHib2RoyMV1+QOokUGELAZPzgW51AU2fp6+J3F9upe/t9BzgZ7bgB2YvbzaNE6p7ypedRVkqrSt0WKT0aiALMUpNWFmGA22VL4N/XDfjIyNIzhflMPDUSAbBG7JOPdD9YjxINAzxmSsryOBexgCempspBg0LKTC6C+XVmQ4kPqDZdcx0JHxNz20vXHM/XtHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>, <Chris.Paterson2@renesas.com>,
        <masami.ichikawa@cybertrust.co.jp>, <uli@fpond.eu>
Subject: [ANNOUNCE] Release v4.19.325-cip116 and v5.10.233-cip56 and
 v6.1.124-cip35
Thread-Topic: [ANNOUNCE] Release v4.19.325-cip116 and v5.10.233-cip56 and
 v6.1.124-cip35
Thread-Index: AdtmRwZJ+mhzpoy6SfmtmlJXBgFFCA==
Date: Tue, 14 Jan 2025 05:45:07 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6391CB653B6F0D286922C2DD92182@OS3PR01MB6391.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6391:EE_|OSZPR01MB9474:EE_
x-ms-office365-filtering-correlation-id: 60fd4f58-69b4-4de1-974c-08dd345e9a14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?Yi9mY1ZFSnhZTXZab1lwVFlpUUEzakhTRDl4UFg2WUxRMDcwL1gxd090?=
 =?iso-2022-jp?B?V1RtWXJkL2pVTzR3cHppWGpwTjJybGllNXdoUTNKTUNTZUlsUUpFUDFo?=
 =?iso-2022-jp?B?T1lzN1NULzlpUlVpRHQ1YUUrTzAvSS9DSGlpWU9LcnNxNXZKOCtEVVFH?=
 =?iso-2022-jp?B?dCt4MG5XZHliaFhsRnI3UUNZbWFLUk80VmF0Q0FVY2lLMzBiL3JtTUpU?=
 =?iso-2022-jp?B?eVRBN2hmMVBDSGhEUEdvLzJiWkhIcE1hc2NGaDFWZ3JxVnRpOThDYVF6?=
 =?iso-2022-jp?B?eTRYNVh2RkJ3dDZRNWsyVXRaQ3V0N0VDNWJiRWNDOU1MbDVIcnRkb3Bj?=
 =?iso-2022-jp?B?aFB4dkhNY3N2dGVIZ1FXWE1PNE1MazZLSmhzWVRIRDdmb0VET3lLUThI?=
 =?iso-2022-jp?B?QWhGZC84L2pheSszRWdxNnZUc3pwV28zN3JLelFsTnpISnZDMnBPY3hZ?=
 =?iso-2022-jp?B?UWJQdkdyUzBheHMrZlJsNENZVUduNFNXY1kvR1c1U0pEbmNsc0FocHl2?=
 =?iso-2022-jp?B?TGprd3M3bmRtNWRsVEN6ci9aRnZjSm1aZ2h5dW5TOUszaHBrOTRLaDJm?=
 =?iso-2022-jp?B?Z3pWckdCQ0YyTnNGWHhzY0QrVmZUaXB3UnNVNGxlWmRZUWUzMUJpYUxV?=
 =?iso-2022-jp?B?cjI3RXBoWDloTitUaXhJWU1FUENzMzErakxuVGZlZE9taEcyeUZKSUdC?=
 =?iso-2022-jp?B?VkdBZGt5VWREanhZYm5veTFlYlUrdHF4aWd6U0g2QjVQeU15bzk5MXhY?=
 =?iso-2022-jp?B?dnpXK1RKYllJNDRDOWlrR2VTNy9YYmVKemtQd3ZMTFI2bWNTVGJ4ZFd5?=
 =?iso-2022-jp?B?SnFpZEJhZ1pUbDJTeWNaT0IzbGZ1cDlNeHpTbmxtS1ZxSjBmS2U1ZkI3?=
 =?iso-2022-jp?B?STBhWWNhZXBIRDJ4WjI0eWU4S3hyd2F1TzY2bis0RVlJaDJTejVXSUZu?=
 =?iso-2022-jp?B?R1pWeXBPQ1MxZnU0Qk1CbjhsNktLU21QbURScTJpRjNSaGlua01USUY3?=
 =?iso-2022-jp?B?L2dQVThka001bkRBV1cyc0gxVVk0bE5Udm1mQmx3T0VxV1p6d1JwbmxU?=
 =?iso-2022-jp?B?bU1RbFpkZTRVcUZ3VjNJT1VZSXdiM2tMd3YvOUVUMVplUHY5eGl4LzZz?=
 =?iso-2022-jp?B?UmhpZy9MY0ZuaTVsbnp6NHFxSWNhTm9BbGR0MjUwSVh2aC93SHZ4V2wz?=
 =?iso-2022-jp?B?cmVBZFJYMW9pWDBHQlo2TWNhNTFnRU5Ka3hrMXFBZHByMk85dHdZZUlS?=
 =?iso-2022-jp?B?ZjJCTXI3RW45OXRHam9ZL1dZNkU0N3MxQ3pGeHZpMGVRQmcvTkM4OHlM?=
 =?iso-2022-jp?B?SDZ2bVFLRm5FTFBhWXU1SzN3NHZCa3JWS1Y1OXQzcEx0U0NyWXdCZTRC?=
 =?iso-2022-jp?B?OHlwbWFDUUt1QnRWUnJKU0EzWm9MdWpXU3RISGVZQkxoMGl5NW43TFU2?=
 =?iso-2022-jp?B?ZUU2MzFoWWNHV2JFTnhPWmxSd1paSWttU0R2NEoyQ2dhUTRJQTEyYUZF?=
 =?iso-2022-jp?B?U3NZc1dGaXBvQm9MV1gzcFUvZDNQYUI5aGdoaXRRWDJ0bmtaRmhZMGhv?=
 =?iso-2022-jp?B?aGl6KzdaSzBoc2c0Q1VWc2ZnNEZJR0F2bFVYTjFaVGw2NlFzbUZmcWRk?=
 =?iso-2022-jp?B?dU9YcUFLWnc1OGJ4T2UrUWUyak9QeEVIZFVIdWFpcXg3UWdhZ0xEUVhV?=
 =?iso-2022-jp?B?dzZQcjdqdnhRQm51a2I1UlVnRFJwUWppQkpKNzU5RHhQdXBOUWFTNFlU?=
 =?iso-2022-jp?B?RVQyNzRYa3JJcG1DTUtVNGI4SlpBS0t4V3hiY0ttbytDaFliVHpPa1Ew?=
 =?iso-2022-jp?B?TjFZaDQxRkdYYTQxdnVJT1huaWlWV3BsT1Y5eXdXWGpMNzJPMVJPQ1pn?=
 =?iso-2022-jp?B?YTJxWFYwMVhPbjZhTXBxUXNXY1o4clZUa3VXRng4amU0Mlc5Zm03MjAz?=
 =?iso-2022-jp?B?S01uVGo0MmNET1NsNHRTbFQvU0w3dHpWVGRXMXdXVkF4YXg5aWpRYmQv?=
 =?iso-2022-jp?B?Q3FxQjRxdTZXdFB5TG1RMmJyODQ0YVBibksveHUxVXIrQ2F2bnVVQ3ZD?=
 =?iso-2022-jp?B?UFM3MDhIQ0c3VkJZV1ZEWldHLzc4UjY4bE5mUXVVMXNsVTBhRm5weXh2?=
 =?iso-2022-jp?B?NVVlTnlTa2VHUE1VRHVhY1hmMlI5UGFKTmpiZStFSktwZWNjQXArRWZs?=
 =?iso-2022-jp?B?TFl3PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6391.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?RFdHZHgvaWVPY2hpbUd1Tm5tRURlTTJxYWdUZ1RNWXVwSU0wS2Y5L2Jn?=
 =?iso-2022-jp?B?ZEJMRVVFdS80eTFYRTVWTU84eTJiN1ovZ1VJdGxUd3BhUml1Njhnem1s?=
 =?iso-2022-jp?B?YXh1RFNyb1NnTk0xYkJ5SlNqM1Yza08xWG4yWFF2WTExUnMwZGQvbzlq?=
 =?iso-2022-jp?B?NjEzZXhlc3V1MzlDOXluRUFEeDR3TmgxQ0NNbHlkZEEyaXB4ekhJelo2?=
 =?iso-2022-jp?B?MVZGMmM0WFREdFlxYjM4NVhnSGdWNTBVa0RLcDhTYll5NEdSOTkxY1lU?=
 =?iso-2022-jp?B?dDZVM1JPZCtVaG5oc2x5RTc1VGlhOFFMM3laVVlhcU85R1B2Y09PRjJv?=
 =?iso-2022-jp?B?YmYxYktZQ2NWVUtBMElBa1l4bzBLSzZCS2NzT0ErTVovRC9nMmxnbTNJ?=
 =?iso-2022-jp?B?L0tnLzJRMjQzUHM5eFZuQU4zKytjTlAwdmZlWnhKUU0ybCtMeEYzbkF4?=
 =?iso-2022-jp?B?ZFJQdXcrNXJJT000Y2YrSXcxTUtQeXVnTms5TUtCbTh3Nm85c3hOZ0xK?=
 =?iso-2022-jp?B?SDBuVWNVY2ZCb2c0cFRBaHIwQjZZMzEzNXJqRlB3dWRFQTM1TlVzWFh5?=
 =?iso-2022-jp?B?ZFFrcU0vTHkvYmNyYXQ0blFhTDVFejRNZzFKaDZlMUJEbnZwdFVOMmYw?=
 =?iso-2022-jp?B?MkFQZGV0SHJGeHN3azkxRXk1K05NTFVtYlBaK2lsOFk3UGNkT0tjZE91?=
 =?iso-2022-jp?B?eWhhWi9KNlRRNmhKZmcxcGhJTFlzUUM3WmRQQk1HaXpvMkQ2UXlKREVh?=
 =?iso-2022-jp?B?eTJFMURGaWllVmdMODkyL2g1TUdSdUVPclpqRUlFbnpGU1FQMCtVcHZh?=
 =?iso-2022-jp?B?S3pyVXZEWTl4WFRrb09KbXl0VkV2NGJvMFR2OUFZaUd0dHhmSlFOZ3Va?=
 =?iso-2022-jp?B?QU1jNWNLTEhiQmtIK0had21wRnRER3JtM0dNYS9KQ3VMOW11STgxTXZ0?=
 =?iso-2022-jp?B?bUNLUTNPVXlVWEt2RTZqTk96ejN5VW1YNlUyZEhYQVVrbWpSeHE3dXJh?=
 =?iso-2022-jp?B?UFhQcWN6eDlmclJwR1VjNThnM0pUNi9iV0JrUGVudW9hMERzT2Jha21s?=
 =?iso-2022-jp?B?MWdGd0JneTU3cGJROHNpQ2dDUG0wN2ZRbzlEUUZvaC9HcEw5NStRYjJa?=
 =?iso-2022-jp?B?TzMvUEFUMHRidTM3SmtlU204dFgrV3FIQ1BRVGVKZzBhT1dMbzVNOE95?=
 =?iso-2022-jp?B?cGpwWFZLeURaQ0dlYVY4NWxHYzNVWmR0SlZOK2t0Q2pINStFQmVJdS94?=
 =?iso-2022-jp?B?cE1ROUpNSFdFUkg4bnpBVmh6dWlML20rNzk0VGFyZWpQMzY4c0x1c3Yx?=
 =?iso-2022-jp?B?YkptRzBhMzBDbFYwd3BNMjE4RHFlbUFQbnZsRm5ISWRkWFFhRGlwZUdj?=
 =?iso-2022-jp?B?ams5OWR3QWRFZnRtNGVhWDhvRWpaOUlPVC9EKys2eDBFU1BNZngzSUoy?=
 =?iso-2022-jp?B?LzVvS3RiRkNKZmhROS9oWDJzTjk3R3NnNkJSSmNtR3hncVMvZ0g0SWMv?=
 =?iso-2022-jp?B?WjhWWktFam9xTVA1cU05WktpeWRTTFpEeXFDVUlhbERRNkZ4ckorbkM0?=
 =?iso-2022-jp?B?VDVlN2R6NmdMekU4cVpiT3FHZnVhWFBMa3FoVWlaMzczdUpOU2JnVzhw?=
 =?iso-2022-jp?B?Qmp0b0FjOFEzRUZSTEdyVE5IQlJxSUphUVBxa1JBTTcza2tJVzFpS1lp?=
 =?iso-2022-jp?B?NnBUZDFLbjltaUt5dlRZSmFNaDk0MU90b3VKSzlwUE1OdnBOQ1VOSW5C?=
 =?iso-2022-jp?B?aHpKajNSbG9ycllDczFxUm1IMm15YkMvcXB4ckdJMzNCbG1DdHV4V0lv?=
 =?iso-2022-jp?B?TWY0dytWRDdxSXh5RjE3VGk4SHpHK3dZcGsyV2RleTQrcTlaT0pWdCtq?=
 =?iso-2022-jp?B?VGpXNlVGdkZjWE5aUXUwaXFzTjZsRmRjS1NIZGVQbHZsNHA2dUloUjVm?=
 =?iso-2022-jp?B?QStKRWcyYlp1TEJjWWhheGN0eG9BYUlRVG5OaGsySlA4ZFBjbnk2WVNO?=
 =?iso-2022-jp?B?RHlmYis2WFFORW9Ia2c4Qi9Za1Ara2JXTmhVd1hoQVBXN2QrbUQ4czRq?=
 =?iso-2022-jp?B?S1BoVWlVQTFUbzQ4RE84dHM5ZU1VQkhkMXNmUnVCVWpRcUs5cmNIa0xN?=
 =?iso-2022-jp?B?VkF2YXpCZ251aVdLT01qQWdNVlZWbjMvTm5mc3pWUERDRDhJaGVkazhn?=
 =?iso-2022-jp?B?eURUbWFTRW41SmRFSlFLMGYwZ1VmeU9Lb0hNc0ZYRmxwWGNvK3BFdG9K?=
 =?iso-2022-jp?B?TE04Si9UYVBsa2dyaDhVZW1tMzhLRXZTajhpdlNncVdCTElaaXFCU0ZP?=
 =?iso-2022-jp?B?UkhFNFZINnVRc002OGFQWXBPTDd4RU55U1E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6391.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60fd4f58-69b4-4de1-974c-08dd345e9a14
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2025 05:45:07.2403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gne/xkxULTQ2rldMu7L59ycnuVHWWtFEZ/53Ilq8EPjxL1Q2H+5P8QtpYRyzFXBPyJNF+CXNkXGI7I+TXbftTjxPoeSq/0Na26LlamwfzScyPpt2Y0iti4GzCgSrXVvZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9474
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Jan 2025 05:45:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17536

Hi,

CIP kernel team has released Linux kernel v4.19.325-cip116 and v5.10.233-ci=
p56 and v6.1.124-cip35.=20
The linux-4.19.y-cip tree has been updated base version from v4.19.324 to v=
4.19.325, and the linux-5.10.y-cip
tree has been updated base version from v5.10.230 to v5.10.233, and the lin=
ux-6.1.y-cip tree has been updated
base version from v6.1.121 to v6.1.124.

Linux-4.19.y-cip is the last release of LTS. This kernel is inherited by CI=
P.

You can get this release via the git tree at:

  v4.19.325-cip116:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      6e07bbcb7050f0840638c734437cc842a855dd10
    fixed CVEs:
      CVE-2022-49034: sh: cpuinfo: Fix a warning for CONFIG_CPUMASK_OFFSTAC=
K
      CVE-2024-53112: ocfs2: uncache inode which has failed entering the gr=
oup
      CVE-2024-53127: Revert "mmc: dw_mmc: Fix IDMAC operation with pages b=
igger than 4K"
      CVE-2024-53130: nilfs2: fix null-ptr-deref in block_dirty_buffer trac=
epoint
      CVE-2024-53131: nilfs2: fix null-ptr-deref in block_touch_buffer trac=
epoint
      CVE-2024-53136: mm: revert "mm: shmem: fix data-race in shmem_getattr=
()"
      CVE-2024-53140: netlink: terminate outstanding dump on socket close
      CVE-2024-53141: netfilter: ipset: add missing range check in bitmap_i=
p_uadt
      CVE-2024-53142: initramfs: avoid filename buffer overrun
      CVE-2024-53146: NFSD: Prevent a potential integer overflow
      CVE-2024-53155: ocfs2: fix uninitialized value in ocfs2_file_read_ite=
r()
      CVE-2024-53156: wifi: ath9k: add range check for conn_rsp_epid in htc=
_connect_service()
      CVE-2024-53157: firmware: arm_scpi: Check the DVFS OPP count returned=
 by the firmware
      CVE-2024-53158: soc: qcom: geni-se: fix array underflow in geni_se_cl=
k_tbl_get()
      CVE-2024-53165: sh: intc: Fix use-after-free bug in register_intc_con=
troller()
      CVE-2024-53172: ubi: fastmap: Fix duplicate slab cache names while at=
taching
      CVE-2024-53173: NFSv4.0: Fix a use-after-free problem in the asynchro=
nous open()
      CVE-2024-53181: um: vector: Do not use drvdata in release
      CVE-2024-53183: um: net: Do not use drvdata in release
      CVE-2024-53184: um: ubd: Do not use drvdata in release
      CVE-2024-53194: PCI: Fix use-after-free of slot->bus on hot remove
      CVE-2024-53197: ALSA: usb-audio: Fix potential out-of-bound accesses =
for Extigy and Mbox devices
      CVE-2024-53214: vfio/pci: Properly hide first-in-list PCIe extended c=
apability
      CVE-2024-53217: NFSD: Prevent NULL dereference in nfsd4_process_cb_up=
date()
      CVE-2024-53227: scsi: bfa: Fix use-after-free in bfad_im_module_exit(=
)
      CVE-2024-53239: ALSA: 6fire: Release resources at card release
      CVE-2024-56531: ALSA: caiaq: Use snd_card_free_when_closed() at disco=
nnection
      CVE-2024-56532: ALSA: us122l: Use snd_card_free_when_closed() at disc=
onnection
      CVE-2024-56539: wifi: mwifiex: Fix memcpy() field-spanning write warn=
ing in mwifiex_config_scan()
      CVE-2024-56548: hfsplus: don't query the device logical block size mu=
ltiple times
      CVE-2024-56681: crypto: bcm - add error check in the ahash_hmac_init =
function
      CVE-2024-56690: crypto: pcrypt - Call crypto layer directly when pada=
ta_do_parallel() return -EBUSY
      CVE-2024-56700: media: wl128x: Fix atomicity violation in fmc_send_cm=
d()
      CVE-2024-56704: 9p/xen: fix release of IRQ
      CVE-2024-56739: rtc: check if __rtc_read_time was successful in rtc_t=
imer_do_work()
      CVE-2024-56746: fbdev: sh7760fb: Fix a possible memory leak in sh7760=
fb_alloc_mem()
      CVE-2024-56747: scsi: qedi: Fix a possible memory leak in qedi_alloc_=
and_init_sb()
    added commits:
      CIP: Bump version suffix to -cip35 after merge from stable

  v5.10.233-cip56:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      6077b17f20b1bcfeccaa23bc05573b938c47679d
    fixed CVEs:
      CVE-2021-49034: sh: cpuinfo: Fix a warning for CONFIG_CPUMASK_OFFSTAC=
K
      CVE-2024-42315: exfat: fix potential deadlock on __exfat_get_dentry_s=
et
      CVE-2024-43098: i3c: Use i3cdev->desc->info instead of calling i3c_de=
vice_get_info() to avoid deadlock
      CVE-2024-44985: ipv6: prevent possible UAF in ip6_xmit()
      CVE-2024-46809: drm/amd/display: Check BIOS images before it is used
      CVE-2024-46841: btrfs: don't BUG_ON on ENOMEM from btrfs_lookup_exten=
t_info() in walk_down_proc()
      CVE-2024-47143: dma-debug: fix a possible deadlock on radix_lock
      CVE-2024-48881: bcache: revert replacing IS_ERR_OR_NULL with IS_ERR a=
gain
      CVE-2024-49571: net/smc: check iparea_offset and ipv6_prefixes_cnt wh=
en receiving proposal msg
      CVE-2024-49974: NFSD: Limit the number of concurrent async COPY opera=
tions
      CVE-2024-49996: cifs: Fix buffer overflow when parsing NFS reparse po=
ints
      CVE-2024-50051: spi: mpc52xx: Add cancel_work_sync before module remo=
ve
      CVE-2024-50055: driver core: bus: Fix double free in driver API bus_r=
egister()
      CVE-2024-50121: nfsd: cancel nfsd_shrinker_work using sync mode in nf=
s4_state_shutdown_net
      CVE-2024-50241: NFSD: Initialize struct nfsd4_copy earlier
      CVE-2024-52332: igb: Fix potential invalid memory access in igb_init_=
module()
      CVE-2024-53073: NFSD: Never decrement pending_async_copies on error
      CVE-2024-53096: mm: resolve faulty mmap_region() error path behaviour
      CVE-2024-53099: bpf: Check validity of link->type in bpf_link_show_fd=
info()
      CVE-2024-53112: ocfs2: uncache inode which has failed entering the gr=
oup
      CVE-2024-53119: virtio/vsock: Fix accept_queue memory leak
      CVE-2024-53121: net/mlx5: fs, lock FTE when checking if active
      CVE-2024-53125: bpf: sync_linked_regs() must preserve subreg_def
      CVE-2024-53127: Revert "mmc: dw_mmc: Fix IDMAC operation with pages b=
igger than 4K"
      CVE-2024-53130: nilfs2: fix null-ptr-deref in block_dirty_buffer trac=
epoint
      CVE-2024-53131: nilfs2: fix null-ptr-deref in block_touch_buffer trac=
epoint
      CVE-2024-53135: KVM: VMX: Bury Intel PT virtualization (guest/host mo=
de) behind CONFIG_BROKEN
      CVE-2024-53136: mm: revert "mm: shmem: fix data-race in shmem_getattr=
()"
      CVE-2024-53138: net/mlx5e: kTLS, Fix incorrect page refcounting
      CVE-2024-53140: netlink: terminate outstanding dump on socket close
      CVE-2024-53141: netfilter: ipset: add missing range check in bitmap_i=
p_uadt
      CVE-2024-53142: initramfs: avoid filename buffer overrun
      CVE-2024-53145: um: Fix potential integer overflow during physmem set=
up
      CVE-2024-53146: NFSD: Prevent a potential integer overflow
      CVE-2024-53148: comedi: Flush partial mappings in error case
      CVE-2024-53150: ALSA: usb-audio: Fix out of bounds reads when finding=
 clock sources
      CVE-2024-53155: ocfs2: fix uninitialized value in ocfs2_file_read_ite=
r()
      CVE-2024-53156: wifi: ath9k: add range check for conn_rsp_epid in htc=
_connect_service()
      CVE-2024-53157: firmware: arm_scpi: Check the DVFS OPP count returned=
 by the firmware
      CVE-2024-53158: soc: qcom: geni-se: fix array underflow in geni_se_cl=
k_tbl_get()
      CVE-2024-53161: EDAC/bluefield: Fix potential integer overflow
      CVE-2024-53164: net: sched: fix ordering of qlen adjustment
      CVE-2024-53165: sh: intc: Fix use-after-free bug in register_intc_con=
troller()
      CVE-2024-53171: ubifs: authentication: Fix use-after-free in ubifs_tn=
c_end_commit
      CVE-2024-53172: ubi: fastmap: Fix duplicate slab cache names while at=
taching
      CVE-2024-53173: NFSv4.0: Fix a use-after-free problem in the asynchro=
nous open()
      CVE-2024-53174: SUNRPC: make sure cache entry active before cache_sho=
w
      CVE-2024-53181: um: vector: Do not use drvdata in release
      CVE-2024-53183: um: net: Do not use drvdata in release
      CVE-2024-53184: um: ubd: Do not use drvdata in release
      CVE-2024-53194: PCI: Fix use-after-free of slot->bus on hot remove
      CVE-2024-53197: ALSA: usb-audio: Fix potential out-of-bound accesses =
for Extigy and Mbox devices
      CVE-2024-53198: xen: Fix the issue of resource not being properly rel=
eased in xenbus_dev_probe()
      CVE-2024-53214: vfio/pci: Properly hide first-in-list PCIe extended c=
apability
      CVE-2024-53217: NFSD: Prevent NULL dereference in nfsd4_process_cb_up=
date()
      CVE-2024-53226: RDMA/hns: Fix NULL pointer derefernce in hns_roce_map=
_mr_sg()
      CVE-2024-53227: scsi: bfa: Fix use-after-free in bfad_im_module_exit(=
)
      CVE-2024-53237: Bluetooth: fix use-after-free in device_for_each_chil=
d()
      CVE-2024-53239: ALSA: 6fire: Release resources at card release
      CVE-2024-53240: Backend can crash Linux netfront
      CVE-2024-53241: Xen hypercall page unsafe against speculative attacks
      CVE-2024-53680: ipvs: fix UB due to uninitialized stack access in ip_=
vs_protocol_init()
      CVE-2024-53690: nilfs2: prevent use of deleted inode
      CVE-2024-55916: Drivers: hv: util: Avoid accessing a ringbuffer not i=
nitialized yet
      CVE-2024-56531: ALSA: caiaq: Use snd_card_free_when_closed() at disco=
nnection
      CVE-2024-56532: ALSA: us122l: Use snd_card_free_when_closed() at disc=
onnection
      CVE-2024-56533: ALSA: usx2y: Use snd_card_free_when_closed() at disco=
nnection
      CVE-2024-56539: wifi: mwifiex: Fix memcpy() field-spanning write warn=
ing in mwifiex_config_scan()
      CVE-2024-56548: hfsplus: don't query the device logical block size mu=
ltiple times
      CVE-2024-56558: nfsd: make sure exp active before svc_export_show
      CVE-2024-56562: i3c: master: Fix miss free init_dyn_addr at i3c_maste=
r_put_i3c_addrs()
      CVE-2024-56567: ad7780: fix division by zero in ad7780_write_raw()
      CVE-2024-56568: iommu/arm-smmu: Defer probe of clients after smmu dev=
ice bound
      CVE-2024-56569: ftrace: Fix regression with module command in stack_t=
race_filter
      CVE-2024-56570: ovl: Filter invalid inodes with missing lookup functi=
on
      CVE-2024-56571: media: uvcvideo: Require entities to have a non-zero =
unique ID
      CVE-2024-56572: media: platform: allegro-dvt: Fix possible memory lea=
k in allocate_buffers_internal()
      CVE-2024-56574: media: ts2020: fix null-ptr-deref in ts2020_probe()
      CVE-2024-56576: media: i2c: tc358743: Fix crash in the probe error pa=
th when using polling
      CVE-2024-56581: btrfs: ref-verify: fix use-after-free after invalid r=
ef action
      CVE-2024-56586: f2fs: fix f2fs_bug_on when uninstalling filesystem ca=
ll f2fs_evict_inode.
      CVE-2024-56587: leds: class: Protect brightness_show() with led_cdev-=
>led_access mutex
      CVE-2024-56589: scsi: hisi_sas: Add cond_resched() for no forced pree=
mption model
      CVE-2024-56593: wifi: brcmfmac: Fix oops due to NULL pointer derefere=
nce in brcmf_sdiod_sglist_rw()
      CVE-2024-56594: drm/amdgpu: set the right AMDGPU sg segment limitatio=
n
      CVE-2024-56595: jfs: add a check to prevent array-index-out-of-bounds=
 in dbAdjTree
      CVE-2024-56596: jfs: fix array-index-out-of-bounds in jfs_readdir
      CVE-2024-56597: jfs: fix shift-out-of-bounds in dbSplit
      CVE-2024-56598: jfs: array-index-out-of-bounds fix in dtReadFirst
      CVE-2024-56600: net: inet6: do not leave a dangling sk pointer in ine=
t6_create()
      CVE-2024-56601: net: inet: do not leave a dangling sk pointer in inet=
_create()
      CVE-2024-56602: net: ieee802154: do not leave a dangling sk pointer i=
n ieee802154_create()
      CVE-2024-56603: net: af_can: do not leave a dangling sk pointer in ca=
n_create()
      CVE-2024-56605: Bluetooth: L2CAP: do not leave dangling sk pointer on=
 error in l2cap_sock_create()
      CVE-2024-56606: af_packet: avoid erroring out after sock_init_data() =
in packet_create()
      CVE-2024-56610: kcsan: Turn report_filterlist_lock into a raw_spinloc=
k
      CVE-2024-56615: bpf: fix OOB devmap writes when deleting elements
      CVE-2024-56616: drm/dp_mst: Fix MST sideband message body length chec=
k
      CVE-2024-56619: nilfs2: fix potential out-of-bounds memory access in =
nilfs_find_entry()
      CVE-2024-56623: scsi: qla2xxx: Fix use after free on unload
      CVE-2024-56629: HID: wacom: fix when get product name maybe null poin=
ter
      CVE-2024-56630: ocfs2: free inode when ocfs2_get_init_inode() fails
      CVE-2024-56633: tcp_bpf: Fix the sk_mem_uncharge logic in tcp_bpf_sen=
dmsg
      CVE-2024-56634: gpio: grgpio: Add NULL check in grgpio_probe
      CVE-2024-56636: geneve: do not assume mac header is set in geneve_xmi=
t_skb()
      CVE-2024-56637: netfilter: ipset: Hold module reference while request=
ing a module
      CVE-2024-56642: tipc: Fix use-after-free of kernel socket in cleanup_=
bearer().
      CVE-2024-56643: dccp: Fix memory leak in dccp_feat_change_recv
      CVE-2024-56644: net/ipv6: release expired exception dst cached in soc=
ket
      CVE-2024-56645: can: j1939: j1939_session_new(): fix skb reference co=
unting
      CVE-2024-56648: net: hsr: avoid potential out-of-bound access in fill=
_frame_info()
      CVE-2024-56650: netfilter: x_tables: fix LED ID check in led_tg_check=
()
      CVE-2024-56659: net: lapb: increase LAPB_HEADER_LEN
      CVE-2024-56661: tipc: fix NULL deref in cleanup_bearer()
      CVE-2024-56662: acpi: nfit: vmalloc-out-of-bounds Read in acpi_nfit_c=
tl
      CVE-2024-56670: usb: gadget: u_serial: Fix the issue that gs_start_io=
 crashed due to accessing null pointer
      CVE-2024-56681: crypto: bcm - add error check in the ahash_hmac_init =
function
      CVE-2024-56688: sunrpc: clear XPRT_SOCK_UPD_TIMEOUT when reset transp=
ort
      CVE-2024-56690: crypto: pcrypt - Call crypto layer directly when pada=
ta_do_parallel() return -EBUSY
      CVE-2024-56691: mfd: intel_soc_pmic_bxtwc: Use IRQ domain for USB Typ=
e-C device
      CVE-2024-56694: bpf: fix recursive lock when verdict program return S=
K_PASS
      CVE-2024-56698: usb: dwc3: gadget: Fix looping of queued SG entries
      CVE-2024-56700: media: wl128x: Fix atomicity violation in fmc_send_cm=
d()
      CVE-2024-56701: powerpc/pseries: Fix dtl_access_lock to be a rw_semap=
hore
      CVE-2024-56704: 9p/xen: fix release of IRQ
      CVE-2024-56705: media: atomisp: Add check for rgby_data memory alloca=
tion failure
      CVE-2024-56716: netdevsim: prevent bad user input in nsim_dev_health_=
break_write()
      CVE-2024-56720: bpf, sockmap: Several fixes to bpf_msg_pop_data
      CVE-2024-56723: mfd: intel_soc_pmic_bxtwc: Use IRQ domain for PMIC de=
vices
      CVE-2024-56724: mfd: intel_soc_pmic_bxtwc: Use IRQ domain for TMU dev=
ice
      CVE-2024-56728: octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2=
_ethtool.c
      CVE-2024-56739: rtc: check if __rtc_read_time was successful in rtc_t=
imer_do_work()
      CVE-2024-56741: apparmor: test: Fix memory leak for aa_unpack_strdup(=
)
      CVE-2024-56746: fbdev: sh7760fb: Fix a possible memory leak in sh7760=
fb_alloc_mem()
      CVE-2024-56747: scsi: qedi: Fix a possible memory leak in qedi_alloc_=
and_init_sb()
      CVE-2024-56748: scsi: qedf: Fix a possible memory leak in qedf_alloc_=
and_init_sb()
      CVE-2024-56754: crypto: caam - Fix the pointer passed to caam_qi_shut=
down()
      CVE-2024-56756: nvme-pci: fix freeing of the HMB descriptor table
      CVE-2024-56759: btrfs: fix use-after-free when COWing tree bock and t=
racing is enabled
      CVE-2024-56763: tracing: Prevent bad count for tracing_cpumask_write
      CVE-2024-56766: mtd: rawnand: fix double free in atmel_pmecc_create_u=
ser()
      CVE-2024-56767: dmaengine: at_xdmac: avoid null_prt_deref in at_xdmac=
_prep_dma_memset
      CVE-2024-56769: media: dvb-frontends: dib3000mb: fix uninit-value in =
dib3000_write_reg
      CVE-2024-56770: net/sched: netem: account for backlog updates from ch=
ild qdisc
      CVE-2024-56779: nfsd: fix nfs4_openowner leak when concurrent nfsd4_o=
pen occur
      CVE-2024-56780: quota: flush quota_release_work upon quota writeback
      CVE-2024-56781: powerpc/prom_init: Fixup missing powermac #size-cells
      CVE-2024-56785: MIPS: Loongson64: DTS: Really fix PCIe port nodes for=
 ls7a
      CVE-2024-57791: net/smc: check return value of sock_recvmsg when drai=
ning clc data
      CVE-2024-57792: power: supply: gpio-charger: Fix set charge current l=
imits
      CVE-2024-57807: scsi: megaraid_sas: Fix for a potential deadlock
      CVE-2024-57849: s390/cpum_sf: Handle CPU hotplug remove during sampli=
ng
      CVE-2024-57850: jffs2: Prevent rtime decompress memory corruption
      CVE-2024-57874: arm64: ptrace: fix partial SETREGSET for NT_ARM_TAGGE=
D_ADDR_CTRL
    added commits:
      CIP: Bump version suffix to -cip56 after merge from stable
      arm64: dts: renesas: rzg3s-smarc-som: Enable the watchdog interface
      arm64: dts: renesas: r9a08g045: Add watchdog node
      watchdog: rzg2l_wdt: Power on the watchdog domain in the restart hand=
ler
      watchdog: rzg2l_wdt: Add suspend/resume support
      watchdog: rzg2l_wdt: Rely on the reset driver for doing proper reset
      watchdog: rzg2l_wdt: Remove comparison with zero
      watchdog: rzg2l_wdt: Remove reset de-assert from probe
      watchdog: rzg2l_wdt: Check return status of pm_runtime_put()
      watchdog: rzg2l_wdt: Use pm_runtime_resume_and_get()
      clk: renesas: r9a08g045: Add clock and reset support for watchdog
      clk: renesas: rzg2l: Fix FOUTPOSTDIV clk
      pinctrl: renesas: rzg2l: Use spin_{lock,unlock}_irq{save,restore}
      pinctrl: renesas: rzg2l: Configure the interrupt type on resume
      pinctrl: renesas: rzg2l: Execute atomically the interrupt configurati=
on

  v6.1.124-cip35:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      a95ad34cd9f7ac6b3c36e4aedd5e20317a7e1ecf
    fixed CVEs:
      CVE-2024-46896: drm/amdgpu: don't access invalid sched
      CVE-2024-47408: net/smc: check smcd_v2_ext_offset when receiving prop=
osal msg
      CVE-2024-49571: net/smc: check iparea_offset and ipv6_prefixes_cnt wh=
en receiving proposal msg
      CVE-2024-50121: nfsd: cancel nfsd_shrinker_work using sync mode in nf=
s4_state_shutdown_net
      CVE-2024-50146: net/mlx5e: Don't call cleanup on profile rollback fai=
lure
      CVE-2024-53099: bpf: Check validity of link->type in bpf_link_show_fd=
info()
      CVE-2024-53164: net: sched: fix ordering of qlen adjustment
      CVE-2024-53690: nilfs2: prevent use of deleted inode
      CVE-2024-55881: KVM: x86: Play nice with protected guests in complete=
_hypercall_exit()
      CVE-2024-55916: Drivers: hv: util: Avoid accessing a ringbuffer not i=
nitialized yet
      CVE-2024-56369: drm/modes: Avoid divide by zero harder in drm_mode_vr=
efresh()
      CVE-2024-56582: btrfs: fix use-after-free in btrfs_encoded_read_endio=
()
      CVE-2024-56709: io_uring: check if iowq is killed before queuing
      CVE-2024-56715: ionic: Fix netdev notifier unregister on failure
      CVE-2024-56716: netdevsim: prevent bad user input in nsim_dev_health_=
break_write()
      CVE-2024-56717: net: mscc: ocelot: fix incorrect IFH SRC_PORT field i=
n ocelot_ifh_set_basic()
      CVE-2024-56718: net/smc: protect link down work from execute after lg=
r freed
      CVE-2024-56759: btrfs: fix use-after-free when COWing tree bock and t=
racing is enabled
      CVE-2024-56762: [REJECTED]: io_uring/sqpoll: fix sqpoll error handlin=
g races
      CVE-2024-56763: tracing: Prevent bad count for tracing_cpumask_write
      CVE-2024-56765: powerpc/pseries/vas: Add close() callback in vas_vm_o=
ps struct
      CVE-2024-56766: mtd: rawnand: fix double free in atmel_pmecc_create_u=
ser()
      CVE-2024-56767: dmaengine: at_xdmac: avoid null_prt_deref in at_xdmac=
_prep_dma_memset
      CVE-2024-56769: media: dvb-frontends: dib3000mb: fix uninit-value in =
dib3000_write_reg
      CVE-2024-57791: net/smc: check return value of sock_recvmsg when drai=
ning clc data
      CVE-2024-57792: power: supply: gpio-charger: Fix set charge current l=
imits
      CVE-2024-57798: drm/dp_mst: Ensure mst_primary pointer is valid in dr=
m_dp_mst_handle_up_req()
      CVE-2024-57807: scsi: megaraid_sas: Fix for a potential deadlock
    added commits:
      CIP: Bump version suffix to -cip35 after merge from stable

Best regards,
   Nobuhiro


