import { Router } from './deps.ts';
import { fetchQuote } from './http.ts';

const router = new Router();

router.get("/", async context => {
    const { response } = context;
    response.body = "Welcome to Deno!"
})

router.get("/quote",async context => {
    const { response } = context;
    const data = await fetchQuote();
    response.body = {...{origin: "https://type.fit/api/quotes"}, ...data[Math.floor(Math.random() * data.length)]};
});

router.get("/greet", async context => {
    const { response } = context;
    response.body = "Welcome to Deno, unknown!"
})

router.post("/greet", async context => {
    const { response, request} = context;
    const { name } = await request.body().value;
    response.status = 200;
    response.body = `Welcome to Deno, ${name ? name : "unknown"}!`;
});

export default router;
