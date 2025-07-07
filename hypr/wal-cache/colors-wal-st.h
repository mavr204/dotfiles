const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#0e0c1e", /* black   */
  [1] = "#32618A", /* red     */
  [2] = "#5C7490", /* green   */
  [3] = "#6F8EAA", /* yellow  */
  [4] = "#799CC1", /* blue    */
  [5] = "#8F99AE", /* magenta */
  [6] = "#A198A1", /* cyan    */
  [7] = "#c2c2c6", /* white   */

  /* 8 bright colors */
  [8]  = "#5e5c70",  /* black   */
  [9]  = "#32618A",  /* red     */
  [10] = "#5C7490", /* green   */
  [11] = "#6F8EAA", /* yellow  */
  [12] = "#799CC1", /* blue    */
  [13] = "#8F99AE", /* magenta */
  [14] = "#A198A1", /* cyan    */
  [15] = "#c2c2c6", /* white   */

  /* special colors */
  [256] = "#0e0c1e", /* background */
  [257] = "#c2c2c6", /* foreground */
  [258] = "#c2c2c6",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
