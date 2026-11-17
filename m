Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.11])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15710.1794914997916409565
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:29:58 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=qqkTh7ln;
 spf=pass (domain: siemens.com, ip: 52.101.83.11, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wotyTjgwmqoKnfpQ36KeuOVYr0RZTchXy+KC49KkHJLeK2uv7+XkgwALPPbYopLKqJhACZvl51zVEyFRCuluBIFtbKNAMkKliOT2KPXpzW6Lkh6Yc6mzwjVC3CKTb+GJb/9znLm4gEW91vSVoQUf6mQXnkimcq4kZ8uhKGD4Z+bDDMXwqlxIa4yH6HWI/Sv0oag3MWcktrTcdS1/quuAbz9psfeJfDwEavJJuK7tVmQExsidPa5FOh6uor1Zo3L+yH1JF9UZ2o7tEEJOVFCNVAgWJe8qxJbHADh/zWJFq59w3nw8wJeeZ3awXtbLlZ5D+nGLDyaZEf/clpfVS8aaMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H56JW1zdKHS+8yHDLlp927eM/md9VRucQCy/3uC7eXU=;
 b=LyJmOjJjpRpR1zKFtKkiqrWIKJU1lijYItvO++peCbmqgH9D7Cve4oR65+2fVMAJm+B37alF64upsdtJX6XRzQeSOIgCCam2uNxdhDQ/ZkQz3fW9+O+8QeH5lUd7Yvd/aN9e968LucXxCHyPL/CdWnCChHtqnqaB3K0uQlNmdxXex9HP1mtp03kAOTMfiyY6p/9Dr3nw7FYlCbulGyZ7MmsgAbf+aW4jzwNgszqYYnvgEEuzDlo29DSfEQmWujcXs+z2YE7BOQMQPZrDOe8OElL/HbGPNF7tEOLq6bxLcP6INcpL3fTPa7LvoE2C9D/Ad//Cp7OJOlPiwBzakAA5wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H56JW1zdKHS+8yHDLlp927eM/md9VRucQCy/3uC7eXU=;
 b=qqkTh7lnBl1/f03q7sMUz3BZe6v2leHX/6ZvVUlx++iSihnk2NJoVxRJ0HIi7fXFpgn6smXFxQAYEodbjF1x8irF6pnkj5hl5jiUM2jWHkFBFThKdly8zxzlWSjXwQ+Vo1XOXfr1nYLOwsu3cAb+xpZHthieUooYi4zRxQVL2/oIq64yd6Yk18mhVSuBzgiDW+A7ulq58Nvg9Ju+Kwo3kE4MbHtbcgwxdNqPYjpItqLw7Poa0DW4y7dy6WNhgNB9eZ7G0zxxrzxp1bwmVdyOyw6u/4F2Y5anBbr8bQCfgp7s0059x+3fzQ2ic+rKj+UycS4qWNwDdM+7/nbMlWNNew==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AS2PR10MB6615.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Tue, 17 Nov
 2026 11:29:54 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0639.005; Tue, 17 Nov 2026
 11:29:54 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v3 16/19] qemu-amd64: load watchdog drivers early via force drivers
Date: Tue, 17 Nov 2026 12:28:30 +0100
Message-ID: <20261117112833.316234-17-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117112833.316234-1-quirin.gylstorff@siemens.com>
References: <20261117112833.316234-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0396.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::10) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AS2PR10MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: bc2e7cf1-8964-4dd9-2ba3-08df449e1a35
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|56012099006|11063799006|261026140227099003|261028144727099003|261026121527099003|261022105027099003|261021121427099003|261102123227099003|261009223027099003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fb8jIzuFB/N/lZ/8CnbmUHYawOWsiYgJ7RxWgNQ1zMLglt1A1EM1EvJ5o75mXMGjO4x1WyOZud4pPgOEPRHZAQZzsPIFB3fe8X23clUJvQqxsywLO+pSSTtLO0byii76hDhhxfzrUXv4cH/0DDygJYcUSxjHhSTjOb7SX5NksnzSih4AI8uYPzdoAEaRmh+Q/BwBFBEs4ro3mdeNYaLRz1diisQjGLMR0InJqm4OXYG2sZlOoTNwMiyu6QM9IovZflLEpF3MFl5GcF5asDTuV27LUYkRH8qYfuAtaHXo3aBhkmXl7rUVTYKQm+zhFXkb7yuOXofwdm5aIVLfWdpKsxZiMOlIocOYrxPVjunlgYkskG4P+ICwcP0FnB1vG8dBEfG9i+2iUccLe+ZDSl7jLwbquxs4EfpJ6qXtF0lX3Kws0Ja6ya5hUKuw9VM+5JCt1I19CzDIMnucxwmRciqNFVoFltfGy6lteXANU/wppUIpQQ8F+DXwEvELJwpPiLcLe6nKGnqmih92Ttjl67WTh1SV7VqWlk8ZsIlcbo1m3O43jM6WCt8/Sf+kXXDGPVynKMLeK+aLW0f7E2x+Ciyc5IJGQ6zX3qwLDzIPNXt6JU1kYg6yEjZ2kfq7v2hzIpIDf7SIvbHa3AHRIU7VVzBNNj5tiwX4L8RTjs6n/c2lE2U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(261026121527099003)(261022105027099003)(261021121427099003)(261102123227099003)(261009223027099003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w+PH250YJotO5wGQ918YWzf3EN2LcaIxZDX7xBUXW7TRg8jeG7PrQKCPyeOi?=
 =?us-ascii?Q?d4yXFqbQA4BxawiO3L1wWjqQGiFojxhUCx1UuplohUHGfoA7VD5KaMzxizZO?=
 =?us-ascii?Q?lsafhRMdqpBhQJulBywX/vi2MJjZDm+So3dNYxV++jH9Gcb9SD3dbpegBUml?=
 =?us-ascii?Q?uS+22gK9D7lKqJYUf0L9ym76U3rsIjwIszn+uUpI1JX8PHqIJl7KuP98jP0k?=
 =?us-ascii?Q?b0WLlmdscFR9DAH7wJxBWBbdEY/bwmOrISnoIOJySWCoQ/8ZNioVqdeFNAbc?=
 =?us-ascii?Q?u59Z3+RvEz/f94+7VCY2b40mxILqU6tqrGDA0aHsBuFKpxBe+4KNYmPqMVxB?=
 =?us-ascii?Q?Pvwv03mmcNYH3F6Y4aXjoTZZj2at0joNzgMPX84V96Zj1fo0LfKPrGvgRjDu?=
 =?us-ascii?Q?OOG4AOJN/VrwQ34JRA3HleDcVPz5IUrj6F0FHITV/znI+isLEA5gtajRIMTI?=
 =?us-ascii?Q?zHzP/42rAqylpxqsKLOWLzFTUVbxlQuoTrdtACm7gtzSKmXJc/OGdpdjWmPp?=
 =?us-ascii?Q?oKcy/iw7Dnr2Ce7qBNz6a2oWcFxlWEXgsMu6toeV4iMIr4vc06wTsD1SdU17?=
 =?us-ascii?Q?UmM1qx3vG0lQA+27OHvOCJrxSlWzwoaeC936zYK7Nvi3L49kFLdDpDy38yHB?=
 =?us-ascii?Q?1zQvEnu8M5DLKIc/S2a14Wn0aGPfvoQPY5Dz//IffMDjHGPgOeZWu8O40I2U?=
 =?us-ascii?Q?L0p46eGtXslStl3qfNrwcFEZ7XmtkCGTHgcc4Vbi+D3SZEyVTTCJWiG5Gwzr?=
 =?us-ascii?Q?tx+1vSVXXYYfGsv2oKdngxK2L+RbLhEplTTrfImcRqz/JD1IGSm0l2r4sUO5?=
 =?us-ascii?Q?9bffLvat03fA1DmBa5TG223dvrv7+4n0CAktJfT7fT3VSZD09TmjY12xk99Y?=
 =?us-ascii?Q?UmN+3O7dLDvmF6tJ3VpeAMiPoa4VxI9/LGoXEsdsPr0LthfcRnXFs1drCFX4?=
 =?us-ascii?Q?4V31XmjFvdra9C0p7KgaBJZ+r81xLmGnZ5mMFWm1xl0qw8QqDhCYpTCFfkF0?=
 =?us-ascii?Q?Ed8taOeXw++KCd9LSlC+WFAO5pfwMlNF8l+L2UD78gR7mH/7RlxQSYrG9UpE?=
 =?us-ascii?Q?birEhkgLc6r1a1UONvGi2ZT/xUrX16pVk6LKA0pLb/YipqYCA9yUg08GEsMZ?=
 =?us-ascii?Q?lKmIG0QhYlJsJ3kaIIUK1NVhRF9NnSCSd9dUX5ISnXPii/53MncLBhe4gFKz?=
 =?us-ascii?Q?0EF66GDufP1NCPrYoVYjP5MndKk6fD2THdLYFZ7ykyIfsvzC2iIce6XVZ5wX?=
 =?us-ascii?Q?ISZiGgSFKAeYclVd9q877RGaJgTq/SOMl9rOJ2DQdcNKbn487t7+TpRhc7v0?=
 =?us-ascii?Q?HusbicP2a8l6YtLJt9LTDH2D52YJ/5PuAC5ur4yiAAnwb9WWnc+vi0tarok5?=
 =?us-ascii?Q?nWXAZO0h48lyyQRj80JSY0pfy2SbvK+aaxs0pTCBE8G68bOpK7tFaYQ0PFbi?=
 =?us-ascii?Q?eEBo3oeZ6vddVXM7JkrLFjWyP/gI/THKxr519MyOQLsmCalup9K951caHZPl?=
 =?us-ascii?Q?C4VXOwgAsYO87MpoXn0uxqNgZTALfOOEW9GlDgkdBo4Y/s6tFMOjY1g2tcME?=
 =?us-ascii?Q?U7IoRfAKPOW++gySkO2uftGlK6CWwq9VU+okgDxZzwkNBcKnQxfuDtQ+hDLO?=
 =?us-ascii?Q?5KOEkaoACNUOpQCbt7WSruV6f4YSOBlFdV2YXFM4/dOGc0d11v6RClVu2MMX?=
 =?us-ascii?Q?EaqCZo+medt8LdfJtdfXfmiN1fqVaNKi2AacyT+iobSrejiqZbRyZd3nItb3?=
 =?us-ascii?Q?euDxWwUoh2lLtkQWmAiqfQVfS12tsW4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2e7cf1-8964-4dd9-2ba3-08df449e1a35
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 11:29:54.6878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lyZL2zDGy/UK7WxCQ2nsbC4L6qePdd9AOPq2iYAXAKEKkCmL1UES/r1MIsVN82vjbUMfRQ1nm3RDeCBcuYdTY0Xx6abt23GfufORrbgvars=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6615
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:29:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24837
Content-Type: text/plain; charset="utf-8"

On qemu-amd64 the iTCO watchdog is not available in the dracut initrd:
iTCO_wdt binds to a platform device created by lpc_ich, and udev does not
load these drivers early enough for systemd to service the watchdog.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/machine/qemu-amd64.conf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/conf/machine/qemu-amd64.conf b/conf/machine/qemu-amd64.conf
index 6cec9b97..b076fe63 100644
--- a/conf/machine/qemu-amd64.conf
+++ b/conf/machine/qemu-amd64.conf
@@ -16,3 +16,5 @@ PREFERRED_PROVIDER_factory-reset-helper:swupdate =3D "fac=
tory-reset-helper-efi"
 # when running without kvm (as in CI so far), 60 seconds might be to short=
,
 # for the bootloader and for the watchdog serviced by systemd and the init=
rd
 WDOG_TIMEOUT =3D "120"
+
+DRACUT_FORCE_DRIVERS +=3D "lpc_ich"
--=20
2.47.3

