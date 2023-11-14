Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28332C4332F
	for <webhook@archiver.kernel.org>; Tue, 14 Nov 2023 00:17:27 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.2255.1699921043803667458
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Nov 2023 16:17:25 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 3AE0H4ae1324188; Tue, 14 Nov 2023 09:17:04 +0900
X-Iguazu-Qid: 2yAaLcf4NzZRGrv198
X-Iguazu-QSIG: v=2; s=0; t=1699921024; q=2yAaLcf4NzZRGrv198; m=W6XLPTaUVM2q3erpMsmJJm+5t1iTR757oVCJg+W5URY=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 3AE0H0kl3263182
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 14 Nov 2023 09:17:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/q6tp4c6M8wJTfV/JJd623LPl+O9YxdApMC9HGsNkyDzp4QTLenJB29tr+lpxF3DcDmWLOhhnlTWQBGv4Uw20WozQV368nHuudYwJ058NXbt3eoOnEiZ3Uq8g7ltQ4li6D+vDPYZml/g2edk6Lh4ZrPlFrrwt9+Ge+1b4H77cVEsDS14v3zmKYc0AyRWpgAMBZxbxbFvhTSvb1Cc8NuYIDIPt7BsFo1fu7sIgnuMjarUGyyu/7JIrSXoOPkqDY//kLxuu0gLk2NFhO77ztOQ3BzilzUhOfm2aQfSwEOhCdF79yfp4oPhfgCSWAZxFsUKKnwsMewrKlFc5gpda8NlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opWvlEGPAGolfeLdD9h8xBrdTILe1rYiAFHFcf+YmPg=;
 b=mQuBkGUx1cwkOQdSHAntIT7tMRnQcbyIjHxW7e986Bt1MrsKOv6Fd3lnuQOOrBZI+DLOHmb2tPiHeGN/hnm9i6Q5+2vBovyWv8Nd1OtlqGmn9SjjADfsOM9HTI4es6wMbq6YNkXj1gtCwCzI2MiNksUlxgcmH8P/HDAIgmZAHT7TfIKNiZ6yT0BVUZMl+VKTm6DIXn5WQE+mEW9vOuzeY7iOFGcH5mtVAur3rn6/ULQyWaXksMibngLuLE99lUFsz0/hnSNzJs2adH95NthqtmcobVdAMhgNjY9vYh6H/mKWHln5TUVWJ9m/lWCPZMaDTNLTCCOjF6vPuPBUSVeM2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>, <Chris.Paterson2@renesas.com>,
        <masami.ichikawa@cybertrust.co.jp>, <uli@fpond.eu>
Subject: [ANNOUNCE] Release v6.1.62-cip9
Thread-Topic: [ANNOUNCE] Release v6.1.62-cip9
Thread-Index: AdoWj834Po4ehGwQQOeD8/1LU+TYLA==
Date: Tue, 14 Nov 2023 00:16:58 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYVPR01MB112455BE2A252B48D9354CA3592B2A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11245:EE_|OS0PR01MB5412:EE_
x-ms-office365-filtering-correlation-id: df558bf3-b51f-44fb-1eed-08dbe4a70454
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 4IR7Yy+z7w68KQD5T7W05md49xr14wOYP8VJ7reri1l089+DKvei6Ohr9mWTxizl6HyykWk2UqSZ5P0wrJTLMMAIprZgpAPpFw7IIG8iY19EsPR06nCqnEydQ11RGCwGbWvZTzScvV33Zj/+WDbjYVmgc8BaUP0TPkg4X5Tr/Ao69vAewHabLy6xbMDxnFDQ7kmFs9PDLh21eOY6WMaUhc/ySs2rGCLpEpgSAYy8vvpfLoNbv9EMQbmDM7R8f6aS/qWQjmqj5F8lHrdFgvFPTXXqGC+nVjyh5/U8c9WQ6h/zX+LcmcaXd1xamd4in4+ERuIGFGTa1+W/mXz1ZeJEsgLAfXHhLKcyp8LuVn5JUJO8maGxa1g9/XujZ2TueHxouzDQReyfh8gUz0yDAzR743a5/q0x+Oyb4Ua0ZeY2dRbvVnlfB14jn9qEs7UDiL2gI87+1as/jTUHrMnUKjIsjN53dAUit21eFXvqiu3MBnYLdi+4QFEoEEq7kF2Kum9UCdn0+Tj0vJCmh0EvwIfzA+RLS1joyHVBcqIXo51BVXhSCCQDHWnr1kMQGNEwiIBJd0rAuH+VAP6SjZuZQuj0gYcmSgYlZHmhBGXW52AcW66ITc4tTYqoX8ZC13Ew5L9Z
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11245.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(376002)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(33656002)(66446008)(9686003)(66476007)(76116006)(478600001)(86362001)(4744005)(55016003)(316002)(38100700002)(83380400001)(64756008)(54906003)(41300700001)(6916009)(26005)(6506007)(2906002)(7696005)(66556008)(66946007)(122000001)(4326008)(8676002)(8936002)(52536014)(71200400001)(966005)(5660300002)(38070700009)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?QWhjakd0aktRS3d4bTZNVnVWWEZRWXJGdzhqNHp3djZlTnA3c3ZxM1J6?=
 =?iso-2022-jp?B?dlJROThhbUdjOU9YRFZvZ29MSTlOMHM2RHRYWlQxVDRxb2RUUjZibUZZ?=
 =?iso-2022-jp?B?dHBvV1l4RU5FSUJrWC9mZzd0NU5yRDMzbFgzVEVSOEhyc21PQVVmd1F2?=
 =?iso-2022-jp?B?V2dHY2xXY2N1SHV6bzNsRm5abFphclpDUEdSVTVCVkhnbHRHUzIwRmQ4?=
 =?iso-2022-jp?B?WUgwemEreHZoSGNwWDc4ZjduOWc4WjJXMXV4a3cxSG5DVlhFVmhSa25U?=
 =?iso-2022-jp?B?aVFLcWdOVmp2MUpleC9DSGZVVEU3UE5zdGU5R0FMKzNLZTByUzNXZHJz?=
 =?iso-2022-jp?B?Qm5lQmVvVW5UUVJ0MEprdFRoTWE2NFJTNVMvUUx6WlJJRjRwQUNGYSs4?=
 =?iso-2022-jp?B?VVZhMjFDQkdCbjV2Qkp0eWllNUNpNkVGb05HMjRPTHcyRkFuMjRRbVJv?=
 =?iso-2022-jp?B?Tk5OTVY4VG1GZldNaUJTd3AwZ2dhUVptM1pFV28ySG9FcUxFMVM4eDlT?=
 =?iso-2022-jp?B?aFlOeTZGdzJVMGpJa00wOVEzMEMzQ05KR0hrUGpBUkRybGZjUXZWNVdt?=
 =?iso-2022-jp?B?b1diU2tyd3J1RThaT0l6VGp5OE5tSHMxU2prQXJTd1ZEMy9xOVk2OVpX?=
 =?iso-2022-jp?B?L3VhOTZETm5zSjF3cXFDRFFza1BCRDk2Q0pBekcwNkY0VGJVM2ZDdWow?=
 =?iso-2022-jp?B?TjB6TXJVa1VHRVB2YlpjVzB5TkxtOVdyU3E2T2ZUQUpiVGVZeTFmT21t?=
 =?iso-2022-jp?B?cWRzMWpVRDZjdlJ1V01OVitTQ3VyTGtMV3RTUzNJNktiZmhxcGRUYjcw?=
 =?iso-2022-jp?B?eWhZZEJKTTJUaEhvNDNtUGpBcU9TbGJlK1dJZDJWRkRsMjVVVG9Fa2pj?=
 =?iso-2022-jp?B?Nk9xT3NwcENMSlZMWlZsNkpOQjNCcy9NcVFtTVY0MzhyVGd2MFZwUVRJ?=
 =?iso-2022-jp?B?a2dPak03Q2U4Ti94L1pyK3YxVTlyWWZXRnNkUFpXcElVTjhyM3pKVHJ4?=
 =?iso-2022-jp?B?cStpNEcrNzRsaHREeW1uOUlQMW8vSkwrVFJkMGxrK0ZKRS9Hc0hWL2cy?=
 =?iso-2022-jp?B?ZHhza2ttRFRtVHBzYWk0dStOMkVUOWtpMkdYUERxTzVZQUZ0TFBkNEY4?=
 =?iso-2022-jp?B?NEpXeThObVkxOEs5SGdHNjdORkVzZGJGUENYVXEvMVpXSG1yYTc5VEVr?=
 =?iso-2022-jp?B?WGRnL2QreURvbk1CMlZ2VDk0b3JncFBhSUZtRWZHNjJNb1k2TC9kVUh4?=
 =?iso-2022-jp?B?c1VLL28vNC9zeUMwbnVpZTIvTDFLaDE1S2ZOTSthRWl6ZmZvN0VQZHRu?=
 =?iso-2022-jp?B?VWZNNHhGVEE0aTFVNUg4VlNGeEFGTlRzSUZxNjk0aW9sZW82KzgwejVR?=
 =?iso-2022-jp?B?aGh4N3B5a2dBZTN4RFdGSmpJZkROa3Y5ckw0WGk4cW0rV1VNSzZwdC9P?=
 =?iso-2022-jp?B?QUZFbGRlN2k5MU5hRytDSGZCVldILzFiMVAwQ0UwOE1va1ZwUHVsUEtv?=
 =?iso-2022-jp?B?eWQzbzFkcVNzSG92T0tZNGFFWXV0emMrQ1RuRVJPdzlZZFJ2VXJuTC8y?=
 =?iso-2022-jp?B?WkdQRWVncXYzNVBLRGlGTXdVcUp2UHA3Y1FLZWhwR043L1hFTThDdk04?=
 =?iso-2022-jp?B?VlJsekxGdmRlRFArMlNQREFZTG9IcTJUeW1tK1hoclJnWXdrRnRsZ2ow?=
 =?iso-2022-jp?B?aTBTZ3ZTQjNBNTRWbnlodm9qVUZNNzlTRDlSemY3SSsrcGEwMFQxcVJE?=
 =?iso-2022-jp?B?blBORk5lSFRTUDZubExMTlJvT3Njd281c1F5Q2xRUEk1Vmk3QnBnbkNC?=
 =?iso-2022-jp?B?MFluaSthSG53NUQ5SGNYc254K2FoVzR5VW1MT1Rhc0xzZ3UwK2hJWTJu?=
 =?iso-2022-jp?B?WlZBYUZXdmk5MGZEaTlLRW0xejlVUXc1VGNhSmMyVi9pcXgyVTdjL280?=
 =?iso-2022-jp?B?NGFDNEN5T0FXaWFuQjl1UW9NT3lmQkwxN1hMUXIxY1dWSktIL2phWGx6?=
 =?iso-2022-jp?B?WjFBRm1Rb2ZCSG5BaFFIOUJ1cVZIVTlVbmFYaC94Z1RNU1FMcWNHQlZv?=
 =?iso-2022-jp?B?NWN0Zk9meTI5TzhreWRVQ1ArcE42VVRKWVFJWHkzMFU4eHM4L3VtQ0pw?=
 =?iso-2022-jp?B?ZEtkK0tKQUVwMTV2TklqbEFhckRCYlI0TUk4RS8vSVRsUWhXVmp5UEJz?=
 =?iso-2022-jp?B?R2pmSUNrcmQ0ZXRjcllkQVZjcVZrZ1hFZ2pqV2dteWlWcWNkYWpvbXFC?=
 =?iso-2022-jp?B?bCtTdEZ0NEg2d24vZmczN1RBdFM1S280V0J4LzRnYjIzN1l0c0VQWUpT?=
 =?iso-2022-jp?B?ZHdXZzFuT0NlalliYUM4UElhZnhsam1zUGc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11245.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df558bf3-b51f-44fb-1eed-08dbe4a70454
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 00:16:58.5745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G5iUKBbHe4rOskBtSdPMaHpluW58nLYB/uEV0qUnsUhAL9Y9H7Rd8HleRHaCSfpq1N3MuMDqc6S5DMelDdUo/Bac951yyOLGDr22N2SoDT9J/ZSf0y0eH8hIqjqlThK7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5412
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Nov 2023 00:17:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13576

Hi all,

CIP kernel team has released Linux kernel v6.1.62-cip9.
The linux-6.1.y-cip tree has been updated base version from v6.1.59 to v6.1=
.62.

You can get this release via the git tree at:

  v6.1.62-cip9:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      5ae5d9581f44f65bc79fe7323153483f8f02a1ea
    Fixed CVEs:
      CVE-2023-46813: SEV-ES local priv escalation for userspace that have =
access to MMIO regions
      CVE-2023-5717: perf: Disallow mis-matched inherited group reads
      CVE-2023-5178: nvmet-tcp: Fix a possible UAF in queue intialization s=
etup
      CVE-2023-46862: io_uring/fdinfo: lock SQ thread while retrieving thre=
ad cpu/pid
      CVE-2023-5090: x86: KVM: SVM: always update the x2avic msr intercepti=
on
    added commits:
      5ae5d9581f44f6 CIP: Bump version suffix to -cip9 after merge from sta=
ble

Best regards,
   Nobuhiro


