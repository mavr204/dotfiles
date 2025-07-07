static const char norm_fg[] = "#c2c2c6";
static const char norm_bg[] = "#0e0c1e";
static const char norm_border[] = "#5e5c70";

static const char sel_fg[] = "#c2c2c6";
static const char sel_bg[] = "#5C7490";
static const char sel_border[] = "#c2c2c6";

static const char urg_fg[] = "#c2c2c6";
static const char urg_bg[] = "#32618A";
static const char urg_border[] = "#32618A";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
