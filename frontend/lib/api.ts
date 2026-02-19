import axios from "axios";
import { User, ApiResponse } from "@/types/user";

const API_BASE_URL = "http://localhost:5000";

const api = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    "Content-Type": "application/json",
  },
});

export const userAPI = {
  // Get local users
  getLocalUsers: async (): Promise<ApiResponse<User[]>> => {
    const response = await api.get("/api/v1/user");
    return response.data;
  },

  // Create local user
  createLocalUser: async (data: Omit<User, "id">): Promise<ApiResponse<User>> => {
    const response = await api.post("/api/v1/user", data);
    return response.data;
  },
};
